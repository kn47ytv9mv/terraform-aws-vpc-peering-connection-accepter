variable "vpc_peering_connection_id" {
  default     = null
  description = "The ID of the peering connection to accept — the id output of terraform-aws-vpc-peering-connection, from the requester account or region."
}

variable "auto_accept" {
  default     = true
  description = "Whether this resource accepts the peering connection. Defaults to true here (AWS's own raw default is false), since accepting is this module's whole purpose — set false only to manage this side's DNS resolution options without changing acceptance."
}

variable "allow_remote_vpc_dns_resolution" {
  default     = null
  description = "Whether this VPC resolves public DNS hostnames of instances in the peer VPC to their private IP addresses. Requires enable_dns_hostnames on this VPC. If null, AWS's own default (false) applies."
}

variable "tags" {
  default     = null
  description = "A map of tags to assign to the accepted peering connection."
}
