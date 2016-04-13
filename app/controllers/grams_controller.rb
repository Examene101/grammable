class GramsController < ApplicationController
	
	def new
	 @gram = Gram.new 
	end
		
	def index
	end

	def create
		# create a gram uisng gram_params
		@gram = Gram.create(gram_params)
		redirect_to root_path
	end

	private
	
	def gram_params
		# params for gram require a gram, permit message
		params.require(:gram).permit(:message)
	end


end
