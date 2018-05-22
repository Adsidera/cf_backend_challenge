module PagesHelper

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

  def courses_collection
    courses.dig("courses")
  end

  def get_friendly_title(course)
    course[1]["title"].gsub("-", " ")
  end

  # From the course api url we get the course content
  # The slug will be the index[0] of each item in courses_collection
  def course_contents(slug)
    get_data_from(course_url(slug))
  end

  def course_details_of(course, key)
    course_contents(course).extract!(key).values
  end

  def readable_course_details_of(course, key)
    course_contents(course).extract!(key).values.join(", ")
  end

  def geo_response
    "http://api.ipstack.com/#{request.remote_ip}?access_key=#{ENV['GEOIP_API_KEY']}"
  end

  def get_geo_response
    get_data_from(geo_response)
  end

  def geo_emoji
    get_geo_response["location"]["country_flag_emoji"]
  end

  def is_uk?
    get_geo_response["country_name"] == "UK"
  end

  def is_eu?
    get_geo_response["location"]["is_eu"] == true && get_geo_response["country_name"] != "UK"
  end

  def link_to_correct_url(slug)
    "https://careerfoundry.com/en/courses/#{slug}"
  end
end
