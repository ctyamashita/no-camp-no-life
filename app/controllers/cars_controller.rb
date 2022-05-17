class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @booking = Booking.new
    @car = Car.find(params[:id])
  end
end
