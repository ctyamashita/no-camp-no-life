class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(current_user.bookings).order(created_at: :asc)
    @cars = policy_scope(Booking.where(car: Car.where(user: current_user))).order(created_at: :asc)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.car = Car.find(params[:car_id])
    @booking.user = current_user
    authorize @booking

    if @booking.save
      redirect_to bookings_path
    else
      @booking = Booking.new(booking_params)
      @booking.car = Car.find(params[:car_id])
      render car_path(@booking.car)
    end
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.update(update_params)
      redirect_to bookings_path, notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :car_id)
  end

  def update_params
    params.require(:booking).permit(:status)
  end
end
