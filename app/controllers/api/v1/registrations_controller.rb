class Api::V1::RegistrationsController < Devise::RegistrationsController

  before_action :ensure_user_params_exists, only: :create
  #registration
  def create
    @user = User.new users_params
    if @user.save
      json_response "Registration Successfully",  true , {user:@user}, :ok
    else
      json_response "Registration Un Successful",  false , {errors:@user.errors}, :unprocessable_entity
    end
  end

  private
  def users_params
    params.require(:user).permit(:email, :password)
  end
  def ensure_user_params_exists
    return if params[:user].present?
    json_response "Missing Params",  false , {}, :bad_request
  end
end
