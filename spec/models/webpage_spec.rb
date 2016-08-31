require 'rails_helper'

RSpec.describe Webpage, type: :model do
  it { should validate_presence_of(:url) }

  it "should have valid url" do
    expect(FactoryGirl.build(:webpage, url: "http://example.com")).to be_valid
    expect(FactoryGirl.build(:webpage, url: "example")).to_not be_valid
  end
end
