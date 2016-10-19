$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "pandago"

require "rspec/its"
require "pry-byebug"

require "webmock/rspec"
WebMock.disable_net_connect!(allow_localhost: true)

SPEC_ROOT = Pathname(__FILE__)/".."

begin
  ping = Net::HTTP.new("localhost", 8080).get("/ping")
rescue Errno::ECONNREFUSED
  raise "PandaGo server must be running at localhost:8080!"
end

PandaGo.url = "http://localhost:8080"

RSpec.configure do |config|
  config.filter_run_including focus: true
  config.run_all_when_everything_filtered = true
end
