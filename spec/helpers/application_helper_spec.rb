require 'rails_helper'
require 'rest_client'

RSpec.describe ApplicationHelper, type: :helper do
  it '#courses is parsed response including courses' do
    url = "https://careerfoundry.com/en/api/courses"
    response = RestClient.get(url)
    parsed_response = JSON.parse(response)
    expect(response.code).to eq(200)
    expect(parsed_response).to include("courses")
  end

  context '#get_geo_response retrieves correct location frome remote ip of user' do
    it 'retrieves response from freegeoip successfully' do
      remote_ip = "46.105.57.150"
      url = "http://api.ipstack.com/#{remote_ip}?access_key=#{ENV['GEOIP_API_KEY']}"
      response = RestClient.get(url)
      parsed_response = JSON.parse(response)
      expect(response.code).to eq(200)
      expect(parsed_response).to include("country_code")
      expect(parsed_response["country_code"]).to eq "FR"
    end
  end
end
