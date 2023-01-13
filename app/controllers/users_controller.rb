class UsersController < ApplicationController
  skip_before_action :authorized, only: [:login, :logout]

  def login
    if params["username"]
      user = User.find_by_username(params["username"])

      if !user.nil?
        @valid = user.authenticate(params["password"])
        
        if @valid
          session[:user_id] = user.id
          redirect_to wiki_posts_path
          return
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      p @user.errors.count
      redirect_to @user, alert: "User created successfully"
    else
      redirect_to new_user_path, aler: "Error creating user"
    end
  end

  def user_params
    params.required(:user).permit(:username, :password, :salt, :encrypted_password)
  end
end
