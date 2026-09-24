resource "aws_vpc_peering_connection_accepter" "resource" {
  vpc_peering_connection_id = var.vpc_peering_connection_id
  auto_accept               = var.auto_accept

  dynamic "accepter" {
    for_each = var.allow_remote_vpc_dns_resolution[*]

    content {
      allow_remote_vpc_dns_resolution = accepter.value
    }
  }

  tags = merge(var.tags, { name = "peering" })
}

output "id" {
  description = "The ID of the accepted peering connection. Identical to the requester side's id."
  value       = aws_vpc_peering_connection_accepter.resource.id
}

output "vpc_id" {
  description = "The ID of this side's VPC."
  value       = aws_vpc_peering_connection_accepter.resource.vpc_id
}

output "peer_vpc_id" {
  description = "The ID of the peer (requester) VPC."
  value       = aws_vpc_peering_connection_accepter.resource.peer_vpc_id
}

output "peer_owner_id" {
  description = "AWS account ID of the peer (requester) VPC."
  value       = aws_vpc_peering_connection_accepter.resource.peer_owner_id
}

output "peer_region" {
  description = "Region of the peer (requester) VPC."
  value       = aws_vpc_peering_connection_accepter.resource.peer_region
}

output "accept_status" {
  description = "Status of the peering connection."
  value       = aws_vpc_peering_connection_accepter.resource.accept_status
}
