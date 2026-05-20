class Api::V1::UsersController < ApplicationController
  before_action :authorize

  
  def profile
    render json: {
      user: {      
          id: current_user.id,
          name: current_user.name,
          email: current_user.email,
          role: current_user.role
          }
     }
  end



end
