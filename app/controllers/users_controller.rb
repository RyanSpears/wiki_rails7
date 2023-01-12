class UsersController < ApplicationController
  def login
    if params["username"]
      user = User.find_by_username(params["username"])

      if !user.nil?
        p 'Found user ' + user.username

        @auth = user.authenticate(params["password"])

        if @auth
          p "You've signed in."
          p @auth
          redirect_to welcome_index_path
          return
        end
      end

      p "Login failed."
    end
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
