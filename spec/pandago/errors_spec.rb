require "spec_helper"

describe PandaGo::ContentTypeNotSupportedError do
  subject { described_class.new("foo") }
  its(:message) { should eq "Content-Type not supported for: foo" }
end

describe PandaGo::UrlNotSetError do
  subject { described_class.new }
  its(:message) { should eq "PandaGo url has not been configured" }
end
