class Api::V1::PropertiesController < ApplicationController

    def index
        properties = Property.all
        render json: properties.to_json(:include => [:apartments, :users])
    end

    def show
        property = Property.find_by(id: params[:id])
        render json: property.to_json(:include => [:apartments, :images])
    end

    def favToggle
        property = Property.find_by(id: params[:id])
        if current_user.properties.include?(property)
            current_user.properties.delete(property)
            render json: false
        else
            current_user.properties << property
            render json: true
        end
    end

    def isFav
        property = Property.find_by(id: params[:id])
        if current_user.properties.include?(property)
            render json: true
        else
            render json: false
        end
    end

end