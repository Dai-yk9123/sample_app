class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
    #'app/views/static_pages/about.html.erb'
  end
  
  def contact
    #'app/views/static_pages/contact.html.erb' contactアクションに対応するテンプレートを追加する。
  end
  
end
