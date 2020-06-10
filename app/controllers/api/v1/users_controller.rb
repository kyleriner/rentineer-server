class Api::V1::UsersController < ApplicationController

    skip_before_action :authorized, only: [:create]

    def profile
        render json: {user: UserSerializer.new(current_user)}, status: :accepted
    end

    def index
        users = User.all
        render json: users
    end

    def show
        render json: current_user.to_json(:include => [:apartments]);
    end

    def new
        user = User.new
    end

    def create
        user = User.create(user_params)
        if user.valid?
            @token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), jwt: @token }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def edit
        user = User.find(params[:id])
    end

    def update

        current_user.update(user_params)
        if current_user.save
            render json: current_user.to_json(:include => [:apartments]);
        else
            render :new
        end
    end

    def destroy
        current_user.destroy
    end

    private
        def user_params
            params.require(:user).permit(:username, :password)
    end
end