$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "pandago"

SPEC_ROOT = Pathname(__FILE__)/".."

require "pry-byebug"

begin
  ping = Net::HTTP.new("localhost", 8080).get("/ping")
rescue Errno::ECONNREFUSED
  raise "PandaGo server must be running at localhost:8080!"
end

Pandago.url = "http://localhost:8080"
