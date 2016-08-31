require 'rails_helper'

RSpec.describe Webpage, type: :model do
  it { should validate_presence_of(:url) }

  it "should have valid url" do
    expect(FactoryGirl.build(:webpage, url: "http://example.com")).to be_valid
    expect(FactoryGirl.build(:webpage, url: "example")).to_not be_valid
  end

  describe "#fetch_page_and_save" do
    it "should call #queue_for_scrapping on create" do
      expect_any_instance_of(Webpage).to receive(:queue_for_scrapping)
      webpage = FactoryGirl.create(:webpage, url: TEST_URL)
    end

    it "should queue for scrapping" do
      VCR.use_cassette('webpage_get_test') do
        expect {
          webpage = FactoryGirl.create(:webpage, url: TEST_URL)
        }.to change(Scrapper.jobs, :size).by(1)
      end
    end

  end

end
