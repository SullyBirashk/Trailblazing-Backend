class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    
    def create
      build_resource(sign_up_params)
  
      resource.save
      render_resource(resource)
    end
  
    private

    def sign_up_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    
      def account_update_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
      end
  
    def render_resource(resource)
      if resource.errors.empty?
        render json: resource
      else
        validation_error(resource)
      end
    end
  
    def validation_error(resource)
      render json: {
        errors: [
          {
            status: '400',
            title: 'Bad Request',
            detail: resource.errors,
            code: '100'
          }
        ]
      }, status: :bad_request
    end
  end
  