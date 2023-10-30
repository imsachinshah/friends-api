class Api::V1::FriendsController < ApplicationController

	before_action :check_id, only: [:show, :update, :destroy]

	def index
		friends = Friend.all

		if friends
			render json: {status: "SUCCESS", message: "Fetched all the friends successfully", data: friends}, status: :ok
		else
			render json: friends.errors, status: :bad_request
		end
	end

	def create
		friend = Friend.new(friend_params)

		if friend.save
			render json: {status: "SUCCESS", message: "Friend created successfully", data: friend}, status: :created
		else
			render json: friend.errors, status: :unprocessable_entity
		end
	end

	def show
		render json: {data: @friend}, status: :ok
	end	

	def update
		if @friend.update!(friend_params)
			render json: {message: "Friend is updated successfully", data: @friend}, status: :ok
		else
			render json: @friend.errors, status: :unprocessable_entity
		end
	end

	def destroy
	  @friend.destroy
		render json: {message: "Friend deleted successfully"}, status: :ok
	end

			

	private
		def friend_params
			params.require(:friend).permit(:name, :location, :email, :twitter, :phone)
		end

		def check_id
			begin
				if params[:id].present?
					@friend = Friend.find(params[:id])
				end
			rescue ActiveRecord::RecordNotFound => e
				render json: {errors: e.message}, status: :bad_request
			end 
		end

end