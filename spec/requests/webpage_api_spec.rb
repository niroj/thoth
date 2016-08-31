require "rails_helper"

RSpec.describe "Webpage API", :type => :request do

  describe "post /webpages" do
    it "scraps a given valid webpage url" do
      expect do
        VCR.use_cassette('webpage_index_api_valid_url') do
          post webpages_path, params: {webpage: {url: TEST_URL}}
          expect(response).to have_http_status(:created)
        end
      end.to change{Webpage.where(url: TEST_URL).count}.by(1)
    end

    it "returns errors for invalid url" do
      expect do
        VCR.use_cassette('webpage_index_api_invalid_url') do
          post webpages_path, params: {webpage: {url: 'example'}}
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end.to change{Webpage.where(url: TEST_URL).count}.by(0)
    end
  end

  describe "get /webpages" do
    before(:each) do
      VCR.use_cassette('return_all_stored_webpages') do
        @webpage = FactoryGirl.create(:webpage, url: TEST_URL)
      end
    end

    it "returns all indexed urls with contents" do
      get webpages_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(TEST_URL)
      expect(JSON.parse(response.body).count).to eql(Webpage.count)
      expect(JSON.parse(response.body).first['sections'].count).to eql(@webpage.sections.count)
    end
  end

  describe "get /webpages/:id" do
    before(:each) do
      VCR.use_cassette('return_single_stored_webpage') do
        @webpage = FactoryGirl.create(:webpage, url: TEST_URL)
      end
    end

    it "returns the index url with contents" do
      get webpage_path(@webpage)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(@webpage.id.to_s)
      expect(response.body).to include(TEST_URL)
      expect(JSON.parse(response.body)['sections'].count).to eql(@webpage.sections.count)
    end
  end
end
