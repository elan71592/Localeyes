class TagsController < ApplicationController
  def index
    @tags = Tag.order( :name )
  end

  def show
    @tag = Tag.find_by( id: params[ :id ] )
    @trips = @tag.trips
  end
end
