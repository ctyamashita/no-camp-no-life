class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.car = Car.find(params[:car_id])
    @booking.user = current_user

    if @booking.save
      redirect_to bookings_path
    else
      render car_path(@booking.car)
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
