class Api::V1::ApartmentsController < ApplicationController
  def index
    apartments = Apartment.all
    render json: apartments
  end

  def show
    apartment = Apartment.find_by(id: params[:id])
    render json: apartment
  end
end
