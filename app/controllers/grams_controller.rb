class GramsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	
	def new
	 @gram = Gram.new 
	end
		
	def index
	end

	def create
		# create a gram uisng gram_params and current user id
		@gram = current_user.grams.create(gram_params)
		#check to if gram valid, if is send to root path, else unprocessable entity
		if @gram.valid?
		 redirect_to root_path
		else
		 render :new, status: :unprocessable_entity
		end
	end

	private
	
	def gram_params
		# params for gram require a gram, permit message
		params.require(:gram).permit(:message)
	end


end
