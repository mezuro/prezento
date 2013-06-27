class RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    #FIXME: Maybe there should be a better way to do this, but it's still not been documented on Devise.
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end