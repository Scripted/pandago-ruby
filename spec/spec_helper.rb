$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "pathname"
require "net/http"

SPEC_ROOT = Pathname(__FILE__)/".."
PANDAGO_URL = URI(ENV.fetch("PANDAGO_URL") { "http://localhost:8080" }).freeze

require "pandago"

require "rspec/its"
require "pry-byebug"

require 'coveralls'
Coveralls.wear!

require "webmock/rspec"
WebMock.disable_net_connect!(allow: PANDAGO_URL.to_s)

begin
  Net::HTTP.new(PANDAGO_URL.host, PANDAGO_URL.port).get("/ping")
rescue
  raise "PandaGo server cannot be found at #{PANDAGO_URL}!"
end

PandaGo.configure do |config|
  config.url = PANDAGO_URL
end

RSpec.configure do |config|
  config.filter_run_including focus: true
  config.run_all_when_everything_filtered = true
end
