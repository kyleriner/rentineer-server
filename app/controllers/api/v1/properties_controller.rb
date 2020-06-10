class Api::V1::PropertiesController < ApplicationController

    def index
        properties = Property.all
        render json: properties.to_json(:include => [:apartments])
    end

    def show
        property = Property.find_by(id: params[:id])
        render json: property
    end

end