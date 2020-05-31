class SessionsController < ApplicationController
    def new
    end

    def create 
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
         session[:user_id] = user.id
         flash[:success] = "You have logged in"
         redirect_to users_path(user)
        else
            if !user
                flash.now[:danger] = "The email is incorrect"
            else
                flash.now[:danger] = "The password is incorrect"
            end
         render 'new'
        end
     end

    def destroy
        session[:user_id] = nil
        redirect_to root_path
    end
 end