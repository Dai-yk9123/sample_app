module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id]) # <= current_userがあれば問合せさせない技を、メモ化またはmemoisと呼ぶ。
    # ↑下の１行をさらにRubyぽく短縮したもの。
    # 　a = a = 1 を a += 1 と書き換えるのと同じイメージ。
    # @current_user = @current_user || User.find_by(id: session[:user_id])
    # 　↑５行をまとめることができる。
    # if @current_user == nil
    #   @current_user = User.find_by(id: session[:user_id])
    # else
    #   @current_user
    # end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
end
