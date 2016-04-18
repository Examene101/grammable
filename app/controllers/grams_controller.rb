class GramsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def update
      @gram = Gram.find_by_id(params[:id])
      return render_not_found if @gram.blank?
      
      @gram.update_attributes(gram_params)
      
      if @gram.valid?
       redirect_to root_path
      else
      	return render :edit, status: :unprocessable_entity
      end
	end
	
	def new
	   @gram = Gram.new 
	end

	def edit
	   @gram = Gram.find_by_id(params[:id])
	   return render_not_found if @gram.blank?  
	end

	def show
	  # show grams using params id
	  @gram = Gram.find_by_id(params[:id])
	  return render_not_found if @gram.blank?
	end
		
	def index
	end

	def create
		#create a gram using gram_params and current user id
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

	def render_not_found
		render text: "Not Found :(", status: :not_found
	end
end
