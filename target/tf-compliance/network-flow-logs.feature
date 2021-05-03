Feature: GCP VPC Security Best Practices
	Scenario: Ensure VPC Should not have default Subnetworks
		Given I have google_compute_network defined
		When it has auto_create_subnetworks
		Then its value must not be null

	Scenario Outline: Ensure VPC Should not have default Subnetworks with entity
			Given I have google_compute_network defined
      When it has auto_create_subnetworks
      Then it must contain <labels>
      And its value must match the "<pattern>" regex
  Examples:
  | labels			| pattern			|
  | auto_create_subnetworks			| ^(False\|false)$	|

#
	Scenario: Ensure VPC Subnetworks Should have flow logs enabled.
		Given I have google_compute_subnetwork defined
		When it has log_config
		Then its value must not be null

	Scenario Outline: Ensure VPC Subnetworks Should have flow logs enabled with entities
			Given I have google_compute_network defined
      When it has log_config
      Then it must contain <labels>
      And its value must match the "<pattern>" regex
  Examples:
  | labels			| pattern			|
  | aggregation_interval			| INTERVAL_10_MIN	|
  | flow_sampling			        | 0.5	|
  | metadata			            | INCLUDE_ALL_METADATA	|