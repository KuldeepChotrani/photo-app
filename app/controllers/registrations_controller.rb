class RegistrationsController < Devise::RegistrationsController

    def create
        build_resource(sign_up_params)

        resource.class.transaction do
            resource.save
            yield resource if block_given?
            if resource.persisted?
                if resource.active_for_authentication?
                sign_up(resource_name, resource)
                     
                else
    
                    set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
                    
                    expire_data_after_sign_in!
                    
                    respond_with resource, location: after_inactive_sign_up_path_for(resource)
    
                end
    
            else
    
                clean_up_passwords resource
                
                set_minimum_password_length
                
                respond_with resource
    
            end
    
        end
    
    end
    
    protected
    
    def configure_permitted_parameters
    
        devise_parameter_sanitizer.for(:sign_up).push(:payment)
    end
    
end