class Api::V1::SessionsController < Devise::SessionsController
  # for login
  before_action :sessions_params, only: :create
  before_action :load_user, only: :create

  # for logout
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy

  def create
    if @user.valid_password?(sessions_params[:password])
      json_response "Login Successful" , true, {user:@user}, :ok
    else
      json_response "Un-Authorized", false, {} ,:unauthorized
    end
  end

  def destroy
    sign_out @user
    token = @user.generate_new_authentication_token
    @user[:authentication_token] = token
    @user.save
    json_response "Logout Successfully ", true, {}, :ok
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
      json_response "User not found", false , {}, :not_found
    end
  end
  def valid_token
    @user = User.where(authentication_token: request.headers["AUTH-TOKEN"]).first
    if @user
      return  @user
    else
      json_response "User not found", false , {}, :not_found
    end
  end
end
