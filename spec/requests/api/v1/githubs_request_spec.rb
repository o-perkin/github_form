require 'rails_helper'

RSpec.describe "Githubs", type: :request do

  describe "GET api/v1" do
    it "given a username, it returns the correct user object" do 
      VCR.use_cassette('api/v1') do
        get "api/v1"
        expect(user.class).to eq(Twitter::User)
        expect(user.username).to eq("sm_debenedetto") 
      end
    end
  end

end
