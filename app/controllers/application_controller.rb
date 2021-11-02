class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :authenticate_user!

    # private
    # def after_sign_out_path_for(resource_or_scope)
    #   sign_in_path
    # end

    # def after_sign_in_path_for(resource_or_scope)
    #   chatroom_path
    # end

    # def after_update_path_for(resource_or_scope)
    #   chatroom_path
    # end

    protected
    
    def configure_permitted_parameters
      added_attrs = [:username, :email, :name, :birthday, :password, :avatar, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :birthday, :email, :avatar, :password, :password_confirmation, :remember_me])
      devise_parameter_sanitizer.permit :sign_in, keys: [:email, :password]
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
