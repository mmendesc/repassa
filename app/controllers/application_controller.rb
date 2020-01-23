class ApplicationController < ActionController::Base
  private

  def request_token
    (auth_header = request.headers['Authorization']) &&
      (token = auth_header.split(' ').last)
  end
end
