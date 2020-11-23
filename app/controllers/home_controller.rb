class HomeController < ApplicationController
  def welcome; end

  def top_commenters
    @users = Users::TopCommentersQuery.call
  end
end
