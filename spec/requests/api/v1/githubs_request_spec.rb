require 'rails_helper'

RSpec.describe "Githubs", type: :request do

  describe "GET /api/v1" do
    it "given empty string, return Not Found" do 
      VCR.use_cassette('api/v1') do
        get "/api/v1"
        expect(json['message']).to eq('Not Found')
        expect(response).to have_http_status(404)
      end
    end

    it "given search parameter with asdasd value, return No name" do 
      VCR.use_cassette('api/v1?search=asdasd') do
        get "/api/v1?search=asdasd"
        expect(json['data']['name']).to eq('No name')
        expect(json['data']['repos']).to eq([])
        expect(response).to have_http_status(200)
      end
    end

    it "given search parameter with o-perkin value, return name and repos" do 
      VCR.use_cassette('api/v1?search=o-perkin') do
        get "/api/v1?search=o-perkin"
        expect(json['data']['name']).to eq('Oleksii Perkin')
        expect(json['data']['repos']).not_to eq([])
        expect(response).to have_http_status(200)
      end
    end

    it "given search parameter with no github user value, return Not Found" do 
      VCR.use_cassette('api/v1?search=lkjasdljkasd') do
        get "/api/v1?search=lkjasdljkasd"
        expect(json['message']).to eq('Not Found')
        expect(response).to have_http_status(404)
      end
    end
  end

end
