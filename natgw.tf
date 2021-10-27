data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}-vpc"]
  }
}

data "aws_subnet" "this" {
  availability_zone = var.az_zone_names[0]

  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}-public-${var.public_sub_env1}-sn"]
  }
}

/*
data "aws_eip" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.natgw_name}-natgw-eip"]
  }
}

data "aws_nat_gateway" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.natgw_name}-natgw"]
  }
}*/

data "aws_route_tables" "this" {
  vpc_id = data.aws_vpc.this.id

  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}-private-rt","${var.vpc_name}-k8s_cni-rt"]
  }
}

resource "aws_eip" "this" {
  vpc = true

  tags = merge(
    {
      "Name" = format("%s-natgw-eip", var.natgw_name)
    },
    local.common_tags,
  )
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = data.aws_subnet.this.id

  depends_on = [
    aws_eip.this,
  ]

  tags = merge(
    {
      "Name" = format("%s-natgw", var.natgw_name)
    },
    local.common_tags,
  )
}

resource "aws_route" "this" {
  for_each = data.aws_route_tables.this.ids

  route_table_id = each.value
  nat_gateway_id = aws_nat_gateway.this.id
  destination_cidr_block = var.default_destination

  depends_on = [
    aws_nat_gateway.this
  ]
}