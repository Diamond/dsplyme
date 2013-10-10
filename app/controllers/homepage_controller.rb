class HomepageController < ApplicationController
  def index
    if logged_in?
      @projects = current_user.projects
    else
      @projects = []
    end
  end
end
