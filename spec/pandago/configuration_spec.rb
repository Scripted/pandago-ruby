require "spec_helper"

describe PandaGo::Configuration do
  describe "url" do
    it "should set url, host, and port" do
      expect { subject.url = "http://example.com:8080" }.
        to  change { subject.url  }.from(nil).to(URI "http://example.com:8080").
        and change { subject.host }.from(nil).to("example.com").
        and change { subject.port }.from(nil).to(8080)
    end
  end
end
