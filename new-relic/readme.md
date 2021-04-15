# New Relic

## Dashboard

Dashboard is an open board feature by newrelic, so we can create custom dashboard with html tag.
we can easily manage information as we want.

for open board we need open board package id from new relic, put at environment variable

```shell
OPEN_BOARD_PACKAGE_ID=xxxx-xxx-xxx
```
current structure dashboard contain company name, and the journeys of the system, we can have multiple journey under
1 company

```shell
dashboards
│   └── company_name
│       └── buyer_journey
│           └── board.hcl
```

for dashboard layout adopt column base layout so every box is under directorate name
![alt text](img/dashboard.png)

in a box there is 3 indicator 
- success rate
- RPS
- Latency

### Sample Dashboard Code

```shell
name = "Example Exec Dashboard Testing"

row {
  group "Company Name" {
    section "Directorate Name A" {
      column {
        node {
          type = "red_module"
          name = "Sample"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }

      }
    }

    section "Directorate Name B" {
      column {
        node {
          type = "red_module"
          name = "Sample Upstream"
          monitor = "monitors/directorate/_sample/conditions/home-page"
        }
      }
    }
  }
}
```

- `row` represent of a row in dashboard, we can have multiple row, usually 1 row have 1 company
- `group` represent of 1 product and consist of multiple directorate
- `section` represent of directorate
- `column` is setup of layout separated by column inside section, so every box/node inside column the position will be in bottom previous box
- `node` is box that showing 3 aspect , RPS, Latency, and Success Rate
- `monitor` is the directory for source RPS, Latency, and Success Rate
- `type` is make differentiate `red_module` and `sr_module` (for now use red_module) red module required 3 source: rps, success-rate, latency. sr_module only success rate.

## Monitor

monitors directory is placement the source of node in dashboard, also channel for alerting,
set condition in each journey per directorate, set the drop rules and also policies of the open incident.

### Channel
- Channel is for alerting purpose, currently we have pagerduty , slack, email and threaded-slack (webhook)

### Conditions
- Condition is consist of 3 part latency , rps, and success rate the have input
    - `nrql_alert_condition_name` is name of condition
    - `nrql_alert_condition_description` is description of condition
    - `nrql_alert_condition_policy_ids` array of policies id
    - `nrql_alert_condition_query` query of condition RPS, Success Rate, Latency
    - `nrql_alert_condition_critical` set object of condition for critical
    - `nrql_alert_condition_warning` set object of condition warning
    
### Dependency
- Dependency is for support the channel, usually use for different resource of terraform

### Drop-Rules
- Dropping Rule is for apply filter to drop the data before goes to NRDB , usually use for reduce cost, and PII data

### Policies
- Policies is set rule for alerting if there is condition warning or critical, we can import the channel that we already create 


## How to Use
- `export NEW_RELIC_ACCOUNT_ID=xxxx`
- `export NEW_RELIC_API_KEY=XXX_XXXXX`
- `export OPEN_BOARD_PACKAGE_ID=XXX_XXX_XXX`

for creating executive dashboard specify the board (layout) setting file `src` and put `docID` docID wil be named in open board newrelic

```shell 
go run ./generator/main.go -src=./new-relic/dashboards/company_name/journey/board.hcl -docID=testing
```

for run `channel`, `conditions`, `dependency`, `drop-rules` and `policies` just run
```shell
terragrunt apply
```

before running this make sure all environment above is filled and also don't forget configuration of terraform state and lock
usually use object storage like s3 and etc.


