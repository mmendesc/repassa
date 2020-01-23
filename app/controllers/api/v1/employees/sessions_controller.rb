# frozen_string_literal: true

# Controller of sessions
class Api::V1::Employees::SessionsController < Api::V1::Employees::ApplicationController
  prepend_before_filter :require_no_authentication, :only => [:create ]
  include Devise::Controllers::InternalHelpers

  before_filter :ensure_params_exist

  respond_to :json

  def create
    build_resource
    resource = Employee.find_by(email: params[:employee][:email])

    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:employee][:password])
      sign_in("employee", resource)
      render json: { success: true, auth_token: resource.token, email: resource.email }
      return
    end
    invalid_login_attempt
  end

  def destroy
    sign_out(resource_name)
  end

  protected

  def ensure_params_exist
    return unless params[:employee].blank?

    render json: {success: false, :message: "missing employee parameter"}, status: 422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
