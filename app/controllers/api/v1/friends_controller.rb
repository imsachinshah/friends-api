class Api::V1::FriendsController < ApplicationController

	before_action :check_id, only: [:show, :update, :destroy]

	def index
		friends = Friend.all

		if friends
			render json: FriendSerializer.new(friends).serializable_hash, status: :ok
		else
			render json: friends.errors, status: :bad_request
		end
	end

	def create
		friend = Friend.new(friend_params)

		if friend.save
			render json: FriendSerializer.new(friend).serializable_hash, status: :created
		else
			render json: friend.errors, status: :unprocessable_entity
		end
	end

	def show
		render json: FriendSerializer.new(@friend).serializable_hash, status: :ok
	end	

	def update
		if @friend.update!(friend_params)
			render json: FriendSerializer.new(@friend).serializable_hash, status: :ok
		else
			render json: @friend.errors, status: :unprocessable_entity
		end
	end

	def destroy
	  @friend.destroy
		render json: {message: "#{@friend.name} Friend deleted successfully"}, status: :ok
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