module ApplicationHelper

  def format_url(url_string)
    url_string.starts_with?("http://") ? url_string : "http://#{url_string}"
  end

  def format_time(post_time)
    time_ago_in_words(post_time)
  end

  def format_datetime(date_time)
    #SEE Ruby-doc for options
    date_time.strftime("%h %d, 20%y at %l:%m%p (%Z)") #Format: 02/28/14 11:00pm (PST)
  end
end
