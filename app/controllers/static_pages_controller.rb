class StaticPagesController < ApplicationController
  def home
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
