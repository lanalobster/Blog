class UsersController < ApplicationController
    def index
        @users = User.search(params[:search]).paginate(page: params[:page], per_page: 20)
    end

    def show
        @user = User.find(params[:id])
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
         @user = User.new(user_params)
        if user_repeat_params[:password] != user_repeat_params[:repeat_password]
            flash[:notice] = "Passwords don't match!"
            render 'new'
        else
            if @user.save
                flash[:success] = "Welcome to MyBlog! #{@user.username}"
                session[:user_id] = User.last.id
                redirect_to articles_path
            else
                render 'new'
            end
        end
    end  
    
    def update
        @user = User.find(params[:id])
        if user_repeat_params[:password] != user_repeat_params[:repeat_password]
            flash[:notice] = "Passwords don't match!" 
            render 'edit'
        else
            if @user.update(user_params)
                flash[:success] = "Your account was updated successfully"
                redirect_to articles_path
            else
                render 'edit'
            end
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Profile was deleted"
        redirect_to root_path
        # redirect_to session_path(@session) method: :delete
    end

    def generate_username
        if(Username.any?)
            max_id = Username.maximum(:id)
            random_id = rand(1..max_id)
            username = Username.find(random_id)
            @username = username.adjective
            random_id = rand(1..max_id)
            username = Username.find(random_id)
            time = Time.now
            @username += "_"+ username.noun + "#{time.sec}"
        else
            @username = "Please run rails db:seed for this function to work"
        end
        respond_to do |format|
           format.js
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def user_repeat_params
        params.require(:user).permit(:username, :email, :password, :repeat_password)
    end

end
