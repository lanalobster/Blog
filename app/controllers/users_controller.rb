class UsersController < ApplicationController
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def show
        @user = User.find(params[:id])
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
         flash[:success] = "Welcome to MyBlog! #{@user.username}"
         redirect_to articles_path
        else
         render 'new'
        end
    end  
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to articles_path
        else
             render 'edit'
        end
    end

    def generate_username
        max_id = Username.maximum(:id)
        random_id = rand(1..max_id)
        username = Username.find(random_id)
        random_id = rand(1..max_id)
        username = Username.find(random_id)
        time = Time.now
        @username = username.adjective + "_"+ username.noun + "#{time.sec}"
        respond_to do |format|
           format.js
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end