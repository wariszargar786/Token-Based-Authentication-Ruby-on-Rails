class Api::V1::SessionsController < Devise::SessionsController
  before_action :sessions_params, only: :create
  before_action :load_user, only: :create
  def create
    if @user.valid_password?(sessions_params[:password])
      json_response "Login Successful" , true,{user:@user},:ok
    else
      json_response "Un-Authorized",false ,{},:unauthorize
    end
  end

  private
  def sessions_params
    params.require(:signin).permit(:email, :password)
  end
  def load_user
    @user = User.find_for_database_authentication(email:sessions_params[:email])
    if @user
      return  @user
    else
      json_response "User not found", false , {}, :failuer
    end
  end
end
