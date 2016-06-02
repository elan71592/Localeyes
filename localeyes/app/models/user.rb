class User < ActiveRecord::Base
  has_many :trips
  has_many :user_trips
  has_many :attended_trips, through: :user_trips, source: :trip
  has_many :comments
  has_many :favorites
  has_many :favorited_trips, through: :favorites, source: :trip

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def formatted_name
    self.first_name + " " + self.last_name[0] + "."
  end
end
