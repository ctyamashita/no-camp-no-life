class CarsController < ApplicationController

  def index
    @cars = policy_scope(Car.where.not(user: current_user)).order(created_at: :asc)
    @cars = policy_scope(@cars.search_by_car_model_and_description_and_capacity(params[:q])) if params[:q].present?
    @cars = policy_scope(@cars.near(params[:address], 500)) if params[:address].present?
    @markers = set_markers(@cars)
  end

  def my_cars
    @my_cars = policy_scope(Car.where(user: current_user))
    authorize @my_cars
  end

  def show
    @car = Car.find(params[:id])
    authorize @car
    @booking = Booking.new
    @my_car = @car.user == current_user
    @marker = set_marker(@car)
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
      redirect_to my_cars_cars_path, notice: "#{@car.car_model} has been added"
    else
      render :new
    end
  end

  def update
    @car = Car.find(params[:id])
    @car.update(car_params)
    authorize @car

    if @car.save
      redirect_to my_cars_cars_path
    else
      render :new
    end
  end

  def destroy
    @car = Car.find(params[:id])
    authorize @car
    @car.destroy
    redirect_to my_cars_cars_path
  end

  private

  def car_params
    params.require(:car).permit(:car_model, :capacity, :description, :price_per_day, :photo, :address)
  end

  def set_markers(cars)
    cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window: render_to_string(partial: 'cars/info_window', locals: { car: car })
      }
    end
  end

  def set_marker(car)
    {
      lat: car.latitude,
      lng: car.longitude,
      info_window: render_to_string(partial: 'cars/info_window', locals: { car: car })
    }
  end
end
