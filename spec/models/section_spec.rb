require 'rails_helper'

RSpec.describe Section, type: :model do
  it "should have valid section_type" do
    expect(FactoryGirl.build(:section, section_type: Section::VALID_TYPES.sample, webpage: Webpage.new)).to be_valid
    expect(FactoryGirl.build(:section, section_type: nil, webpage: Webpage.new)).to_not be_valid
  end

  it "should contain webpage" do
    expect(FactoryGirl.build(:section, webpage: Webpage.new)).to be_valid
    expect(FactoryGirl.build(:section, webpage: nil)).to_not be_valid
  end

end
