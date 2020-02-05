module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ユーザーを永続的に復元できるようになった
  def remember(user)   
    user.remember                                           # => DB: remember_digest
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])  # => use_idにsession[:user_id]を代入し、その値がnilかその他かをif文で確認している
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # 現在ログインしているユーザーを返す（いる場合）
  # def current_user
  #   if session[:user_id]
  #     @current_user ||= User.find_by(id: session[:user_id]) # <= current_userがあれば問合せさせない技を、メモ化またはmemoisと呼ぶ。
    # ↑下の１行をさらにRubyぽく短縮したもの。
    # 　a = a = 1 を a += 1 と書き換えるのと同じイメージ。
    # @current_user = @current_user || User.find_by(id: session[:user_id])
    # 　↑５行をまとめることができる。
    # if @current_user == nil
    #   @current_user = User.find_by(id: session[:user_id])
    # else
    #   @current_user
    # end
  #   end
  # end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
end
