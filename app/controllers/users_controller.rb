class UsersController < ApplicationController
  # GET /users/1/projects
  def projects
    @user = User.find(params[:user_id].to_i)
  end
end
