class WelcomeController < ApplicationController

  def index
    @featured = Trip.where( featured: true )
  end

end
