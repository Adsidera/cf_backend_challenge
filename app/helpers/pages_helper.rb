module PagesHelper
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

  # This is just a plus method to fetch a fancy emoji for the country of the internet visitor from the response
  def geo_emoji
    get_geo_response["location"]["country_flag_emoji"]
  end

  # Method is_uk? and is_eu? are to check the country of origin of the internet visitor
  # and will be used to show the course price with the appropriate currency
  def is_uk?
    get_geo_response["country_code"] == "GB"
  end

  def is_eu?
    get_geo_response["location"]["is_eu"] == true && get_geo_response["country_code"] != "GB"
  end

  # This is to fetch the url to the course that is linked in the button 'Enroll'
  def link_to_correct_url(slug)
    "https://careerfoundry.com/en/courses/#{slug}"
  end
end
