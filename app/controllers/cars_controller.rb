class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
  @car = Car.find(params[:id])
  
  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
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
