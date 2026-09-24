mock_provider "aws" {
}

run "connection_id_passes_through_and_auto_accept_defaults_true" {
  command = plan

  variables {
    vpc_peering_connection_id = "pcx-0123456789abcdef0"
  }

  assert {
    condition     = aws_vpc_peering_connection_accepter.resource.vpc_peering_connection_id == "pcx-0123456789abcdef0"
    error_message = "vpc_peering_connection_id should pass through unchanged."
  }

  assert {
    condition     = aws_vpc_peering_connection_accepter.resource.auto_accept == true
    error_message = "auto_accept should default to true here — a deliberate deviation from AWS's own raw false default, since accepting is this module's entire purpose."
  }

  assert {
    condition     = length(aws_vpc_peering_connection_accepter.resource.accepter) == 0
    error_message = "allow_remote_vpc_dns_resolution was not set, so no accepter block should be rendered."
  }
}

run "auto_accept_can_be_disabled" {
  command = plan

  variables {
    vpc_peering_connection_id = "pcx-0123456789abcdef0"
    auto_accept               = false
  }

  assert {
    condition     = aws_vpc_peering_connection_accepter.resource.auto_accept == false
    error_message = "auto_accept should be overridable to false, for managing this side's options without changing acceptance state."
  }
}

run "allow_remote_vpc_dns_resolution_renders_accepter_block" {
  command = plan

  variables {
    vpc_peering_connection_id       = "pcx-0123456789abcdef0"
    allow_remote_vpc_dns_resolution = true
  }

  assert {
    condition     = aws_vpc_peering_connection_accepter.resource.accepter[0].allow_remote_vpc_dns_resolution == true
    error_message = "allow_remote_vpc_dns_resolution = true should render an accepter block with the same value."
  }
}

run "readme_default_example" {
  command = plan

  variables {
    vpc_peering_connection_id = "pcx-0123456789abcdef0"
  }
}

run "readme_custom_example" {
  command = plan

  variables {
    vpc_peering_connection_id       = "pcx-0123456789abcdef0"
    allow_remote_vpc_dns_resolution = true
  }

  assert {
    condition     = aws_vpc_peering_connection_accepter.resource.accepter[0].allow_remote_vpc_dns_resolution == true
    error_message = "The README's custom example should enable DNS resolution on the accepter side."
  }
}
