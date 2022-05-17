class CarsController < ApplicationController
  def index
    @cars = policy_scope(Car).order(created_at: :asc)
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car.user = User.find(params[:car_id])
    authorize @car

    if @car.save
      redirect_to cars_path(@car)
    else
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:car_model, :capacity, :description, :price_per_day)
  end
end
