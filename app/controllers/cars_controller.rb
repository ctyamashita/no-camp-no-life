class CarsController < ApplicationController
  def index

    if params[:q].present?
      @cars = policy_scope(Car.search_by_car_model_and_description_and_capacity(params[:q]))
      @markers = @cars.geocoded.map do |car|
        {
          lat: car.latitude,
          lng: car.longitude,
          info_window: render_to_string(partial: 'cars/info_window', locals: { car: car })
        }
      end
    elsif params[:address].present?
      @cars = policy_scope(Car.near(params[:address], 70))
      @markers = @cars.geocoded.map do |car|
        {
          lat: car.latitude,
          lng: car.longitude,
          info_window: render_to_string(partial: 'cars/info_window', locals: { car: car })
        }
      end
    else
      @cars = policy_scope(Car.where.not(user: current_user)).order(created_at: :asc)
    end


  end

  def show
    @car = Car.find(params[:id])
    authorize @car
    @booking = Booking.new
  end

  def new
    @car = Car.new
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    authorize @car

    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def update
    @car = Car.find(params[:id])
    @car.update(car_params)
    authorize @car

    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:car_model, :capacity, :description, :price_per_day, :photo)
  end
end
