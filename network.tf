# network.tf

# Fetch AZs in the current region
data "aws_availability_zones" "my-available-azs" {
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "172.17.0.0/16"
}

# Create var.my-az-count private subnets, each in a different AZ
resource "aws_subnet" "my-priv-subnet" {
  count             = var.my-az-count
  cidr_block        = cidrsubnet(aws_vpc.my-vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.my-available-azs.names[count.index]
  vpc_id            = aws_vpc.my-vpc.id
}

# Create var.my-az-count public subnets, each in a different AZ
resource "aws_subnet" "my-pub-subnet" {
  count                   = var.my-az-count
  cidr_block              = cidrsubnet(aws_vpc.my-vpc.cidr_block, 8, var.my-az-count + count.index)
  availability_zone       = data.aws_availability_zones.my-available-azs.names[count.index]
  vpc_id                  = aws_vpc.my-vpc.id
  map_public_ip_on_launch = true
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
}

# Route the public subnet traffic through the IGW
resource "aws_route" "my-internet-route" {
  route_table_id         = aws_vpc.my-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my-igw.id
}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "my-eip-igw" {
  count      = var.my-az-count
  vpc        = true
  depends_on = [aws_internet_gateway.my-igw]
}

resource "aws_nat_gateway" "my-ngw" {
  count         = var.my-az-count
  subnet_id     = element(aws_subnet.my-pub-subnet.*.id, count.index)
  allocation_id = element(aws_eip.my-eip-igw.*.id, count.index)
}

# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "my-rt-priv" {
  count  = var.my-az-count
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.my-ngw.*.id, count.index)
  }
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "my-rt-assoc" {
  count          = var.my-az-count
  subnet_id      = element(aws_subnet.my-priv-subnet.*.id, count.index)
  route_table_id = element(aws_route_table.my-rt-priv.*.id, count.index)
}