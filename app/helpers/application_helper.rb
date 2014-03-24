module ApplicationHelper
  def net_votes # Needed here for sorting.
    self.upvotes_count - self.downvotes_count
  end
  def upvotes_count
    self.votes.where(vote: true).size
  end
  def downvotes_count
    self.votes.where(vote: false).size
  end

  # Format User-Provided URL's to ensure http://
  def format_url(url_string)
    url_string.starts_with?("http://") ? url_string : "http://#{url_string}"
  end

  # Format time for display on posts & comments
  def format_datetime(date_time)
    unless !logged_in? || current_user.timezone.nil?
      date_time = date_time.in_time_zone(current_user.timezone)
    end
    #SEE Ruby-doc for options
    date_time.strftime("%h %d, 20%y at %l:%m%p (%Z)") #Format: 02/28/14 11:00pm (PST)
  end
end
