class UsersController < ApplicationController
  # GET /users/:id
  def show
    @user = User.find(params[:id])
    # => app/views/users/show.html.erbls
    # debugger
  end
  
  def new
    @user = User.new
  end
  
  def create
#    @user = User.new()←カッコ内にはキー（シンボル）、バリューがある。ハッシュのハッシュである。
#    @user.name     = params[:user][:name]
#    @user.email    = params[:user][:email]
#    @user.password = params[:user][:password]　全てまとめて↓１行でできる。
    @user = User.new(user_params)
    if @user.save #=> Validation
      # Success
      flash[:success] = "Welcome to the Sample App!"
      # redirect_to user_path(@user.id)　↓同じ挙動
      # redirect_to user_path(@user)　↓同じ挙動
      redirect_to @user
      # => GET "/users/#{@user.id}" => show
    else
      # Failure
      render 'new'
    end
  end
  
  def user_params
    params.require(:user).permit(
      :name, :email, :password, 
      :password_confirmation)
  end
  
end
