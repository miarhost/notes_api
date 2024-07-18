require 'rspec/json_expectations'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:each) do
    stub_request(:get, ENV['WEBHOOK_URL']).
    with(
      headers: {
      'Accept'=>'application/json',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Length'=>'113',
      'Content-Type'=>'application/json',
      'Host'=>'webhook:9902',
      'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: [{'title': 'example', 'payload': 'example text'},{'title': 'example 1', 'payload': 'example 1 text'},{'title': 'example 2', 'payload': 'example 2 text'}], headers: {})
  end
end
