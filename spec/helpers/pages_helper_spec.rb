require 'rails_helper'
require 'rest_client'

RSpec.describe PagesHelper, type: :helper do
  it 'checks correctly origin of ip address' do
    french_remote_ip = "46.105.57.150"
    response = RestClient.get("http://api.ipstack.com/#{french_remote_ip}?access_key=#{ENV['GEOIP_API_KEY']}")
    get_geo_response = JSON.parse(response)
    expect(get_geo_response).to include("country_name")
    expect(get_geo_response["country_name"]) != "UK"
    expect(get_geo_response["location"]["is_eu"]).to eq true
  end
end
