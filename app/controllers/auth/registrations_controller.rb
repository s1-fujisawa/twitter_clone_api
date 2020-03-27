class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:nickname])
    end

    private 

    def account_update_params
      params.permit(:name, :nickname, :email)
    end

end
