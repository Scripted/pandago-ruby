require "spec_helper"

describe Pandago::ContentTypes do
  its([:markdown]) { should eq "text/markdown; charset=UTF-8" }
  its([:html]) { should eq "text/html; charset=utf-8" }
  its([:docx]) { should eq "application/vnd.openxmlformats-officedocument.wordprocessingml.document" }

  it "raises when a format is not supported" do
    expect { described_class[:invalid] }.to raise_error /not supported/
  end
end
