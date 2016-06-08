module ApplicationHelper
  def formatted_date(timestamp)
    timestamp.strftime('%B %e, %Y')
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end
  # There is a built in method for elapsed time called "time_ago_in_words(timestamp)"

  def split_tags(tag_array)
    if tag_array.include?( ", " )
      return tag_array.split( ", ")
    else
      return tag_array.split( " " )
    end
  end

  def find_create_tags(tag)
    if tag[0] == "#"
      return new_tag = Tag.find_or_create_by( name: tag[ 1..-1 ] )
    else
      return new_tag = Tag.find_or_create_by( name: tag )
    end
  end
end
