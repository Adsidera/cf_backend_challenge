module ApplicationHelper
  def get_data_from(url)
    response = RestClient.get(url)
    JSON.parse(response)
  end

  def base_url
    "https://careerfoundry.com/en/api/courses"
  end

  def course_url(slug)
    "https://careerfoundry.com/en/api/courses/#{slug}"
  end

  def courses
    get_data_from(base_url)
  end

  # The correct link to send the api call to is assigned to the geo_response method
  def geo_response
    "http://api.ipstack.com/#{request.remote_ip}?access_key=#{ENV['GEOIP_API_KEY']}"
  end

  # The method get_geo_response is the parsed response thanks to the previous helper method get_data_from(url)
  def get_geo_response
    get_data_from(geo_response)
  end
end
