require 'rails_helper'

RSpec.describe GramsController, type: :controller do
	describe "grams#destroy" do
     it "should allow a user to destroy grams" do
     	p = FactoryGirl.create(:gram)
     	delete :destroy, id: p.id
     	expect(response).to redirect_to root_path
     	p = Gram.find_by_id(p.id)
     	expect(p).to eq nil
      
     end

     it "should return a 404 message if we cannot find a gram with the id that is specified" do
        delete :destroy, id: 'SPACEDUCK'
        expect(response).to have_http_status(:not_found) 
     end
    
    end
    describe "grams#update" do
	  it "should allow users to successfully update grams" do
	  	p = FactoryGirl.create(:gram, message: "Initial Value")
	  	patch :update, id: p.id, gram: { message: "Changed"}
	  	expect(response).to redirect_to root_path
	  	p.reload
	  	expect(p.message).to eq "Changed"
	      
	  end

	  it "should have http 404 error if the gram cannot be found" do
	  	patch :update, id: "YOLOSWAG", gram: {message: 'Changed'}
        expect(response).to have_http_status(:not_found)
	      
	  end

	  it "should render the edit form with an http status of unprocessable_entity" do
	  	 p = FactoryGirl.create(:gram, message: "Initial Value")
	  	 patch :update, id: p.id, gram: { message: '' }
	  	 expect(response).to have_http_status(:unprocessable_entity)
	  	 p.reload
         expect(p.message).to eq "Initial Value"  
	  end
    end


	describe "grams#edit" do
      it "should successfully show the edit form if the gram is found" do
      	p = FactoryGirl.create(:gram)
      	get :edit, id: p.id
      	expect(response).to have_http_status(:success)
      
      end
    
      it "should return a 404 error message if the gram is not found" do
      	get :edit, id: "SWAG"
      	expect(response).to have_http_status(:not_found)
      
      end
    end
	

	describe "grams#show action" do
	    it "should successfully show the page if the gram is found" do
	    	gram = FactoryGirl.create(:gram)
	    	get :show, id: gram.id
	    	expect(response).to have_http_status(:success)
	      
	    end
	    
	    it "should return a 404 error if the gram is not found" do
	    	get :show, id: "TACOCAT"
	    	expect(response).to have_http_status(:not_found)
	      
	    end
	end


	describe "grams#index action" do
		it "should successfully show page" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "grams#new action" do 
		it "should require user to be logged in" do
			get :new
			expect(response).to redirect_to new_user_session_path

		end
		
		it "should successfully show the new form" do
			#authenticate user id(email) and password
		  user = FactoryGirl.create(:user)
            sign_in user   

			get :new
			expect(response).to have_http_status(:success)
		end
	end
   
   
    # protocal for create action
	describe "grams#create action" do
		it "should require users to be logged in" do
		  post :create, gram: { message: "Hello"}
		  expect(response).to redirect_to new_user_session_path
	    end
		
		it "should successfully create a new gram in our databse" do
		  user = FactoryGirl.create(:user)
		    sign_in user
			
			post :create, gram: {message: "Hello!"}
			expect(response).to redirect_to root_path

			gram = Gram.last
			expect(gram.message).to eq("Hello!")
			expect(gram.user).to eq(user)
		end

		
		it "should prperly deal with validation errors" do
		 user = FactoryGirl.create(:user) 
		  sign_in user
		  
		  post :create, gram: {message: ''}
		  expect(response).to have_http_status(:unprocessable_entity)
		  expect(Gram.count).to eq 0

	    end
	end

end
