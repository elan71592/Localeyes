module ApplicationHelper
  def formatted_date(timestamp)
    timestamp.strftime('%B %e, %Y')
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end
  # There is a built in method for elapsed time called "time_ago_in_words(timestamp)"
end
