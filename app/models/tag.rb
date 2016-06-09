class Tag < ActiveRecord::Base
  has_many :trip_tags
  has_many :trips, through: :trip_tags

  def self.split_tags(tag_array)
    if tag_array.include?( ", " )
      return tag_array.split( ", ")
    else
      return tag_array.split( " " )
    end
  end

  def self.find_create_tags(tag)
    if tag[0] == "#"
      downcase_tag = tag[1..-1].downcase
      return new_tag = Tag.find_or_create_by( name: downcase_tag )
    else
      downcase_tag = tag[1..-1].downcase
      return new_tag = Tag.find_or_create_by( name: downcase_tag )
    end
  end
end
