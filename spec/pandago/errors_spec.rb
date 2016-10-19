require "spec_helper"

describe PandaGo::ContentTypeNotSupportedError do
  subject { described_class.new("foo") }
  its(:message) { should eq "Content-Type not supported for: foo" }
end

describe PandaGo::UrlNotSetError do
  its(:message) { should eq "PandaGo url has not been configured" }
end

describe PandaGo::RequestError do
  let(:response) { double("HTTP Response", code: 9001, message: "Over Nine-Thousand") }
  subject { described_class.new(response) }
  its(:message) { should eq "9001 Over Nine-Thousand" }
end

describe PandaGo::TimeoutError do
  around do |example|
    old_timeout = PandaGo.configuration.timeout
    PandaGo.configuration.timeout = 42
    example.run
    PandaGo.configuration.timeout = old_timeout
  end

  its(:message) { should eq "Request took longer than 42 seconds" }
end
