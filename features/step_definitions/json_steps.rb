# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
Then /^I should get a json object with the following:$/ do |fields|
  debugger
  fields.rows_hash.each do |key, value|
    Then %{I fill in "#{name}" with "#{value}"}
  end
end



json = Hash[*response.body.scan(/bucket":{"(.*):(.*)}/).to_a.flatten]

json = Hash[*Bucket.first.to_json.scan(/"bucket":{"(.*):(.*)}/).to_a.flatten]


"{\"bucket\":{\"name\":\"Plants\",\"updated_at\":\"2009-09-09T17:59:27Z\",\"id\":1518,\"created_at\":\"2009-09-09T17:59:27Z\"}}"

