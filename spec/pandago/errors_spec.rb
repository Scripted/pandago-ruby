require "spec_helper"

describe Pandago::ContentTypeNotSupportedError do
  subject { described_class.new("foo") }
  its(:message) { should eq "Content-Type not supported for: foo" }
end

describe Pandago::UrlNotSetError do
  subject { described_class.new }
  its(:message) { should eq "Pandago.url has not been set" }
end
