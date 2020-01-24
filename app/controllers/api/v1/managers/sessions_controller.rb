# frozen_string_literal: true

# Controller of sessions
class Api::V1::Managers::SessionsController < Api::V1::Managers::ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_token

  include Devise::Controllers::Helpers

  before_action :ensure_params_exist

  respond_to :json

  def create
    resource = Manager.find_by(email: params[:login][:email])

    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:login][:password])
      sign_in("manager", resource)
      render json: { success: true, auth_token: resource.token, email: resource.email, namespace: 'managers', name: resource.name }
      return
    end
    invalid_login_attempt
  end

  def destroy
    sign_out(resource_name)
  end

  protected

  def ensure_params_exist
    return unless params[:login].blank?

    render json: {success: false, message: "missing manager parameter"}, status: 422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
