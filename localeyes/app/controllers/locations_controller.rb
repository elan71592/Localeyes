class LocationsController < ApplicationController

  def new
  end

  def create
    binding.pry
  end

  def destroy

  end

  private

    def location_params
      params.require( :place ).permit( :name, :address, :phone_number, :website )
    end
end
