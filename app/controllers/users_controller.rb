class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers] # => methodoを呼び出す際は、シンボルで呼び出す。
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  # => before_actionは順序が大切なので注意する。上から順に実行される。１行目でログインの確認、２行目で本人の確認。
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # GET /users/:id
  def show
    @user = User.find(params[:id])
    # => app/views/users/show.html.erbls
    # debugger
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users
  def create
#    @user = User.new()←カッコ内にはキー（シンボル）、バリューがある。ハッシュのハッシュである。
#    @user.name     = params[:user][:name]
#    @user.email    = params[:user][:email]
#    @user.password = params[:user][:password]　全てまとめて↓１行でできる。
    @user = User.new(user_params)
    if @user.save #=> Validation
      # Success
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # ↓↓↓ メールによる本人確認を実行するため以下の挙動をコメントアウトした
      # log_in @user
      # flash[:success] = "Welcome to the Sample App!"
      # # redirect_to user_path(@user.id)　↓同じ挙動
      # # redirect_to user_path(@user)　↓同じ挙動
      # redirect_to @user
      # # => GET "/users/#{@user.id}" => show
    else
      # Failure
      render 'new'
    end
  end
  
  # GET /users/:id/edit
  # params[:id] => :id
  def edit
    @user = User.find(params[:id])
    # => app/views/users/edit.html.erb
  end
  
  # PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Success
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      # Failure
      # => user.errors.full_messages()
      render 'edit'
    end
  end
  
  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  # privateと宣言した後に実行されるメソッドは全てprivateなメソッドになる
  private
  
    def user_params
      params.require(:user).permit(
        :name, :email, :password, 
        :password_confirmation)
    end
  
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user
      # GET   /users/:id/edit
      # PATCH /users/:id
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) # <= @user == current_user
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
