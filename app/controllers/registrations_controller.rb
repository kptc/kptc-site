class RegistrationsController < Devise::RegistrationsController
  
  def new
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    @genders = Gender.all
    respond_with self.resource
  end
  
  private

  def sign_up_params
    params.require(:player).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :gender_id,
      :password,
      :password_confirmation
    )
  end

  def account_update_params
    params.require(:player).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :gender_id,
      :password,
      :password_confirmation,
      :current_password
    )
  end
  
end