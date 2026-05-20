class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decode_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, Rails.application.secret_key_base,true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end
  
  def current_user
    if decode_token
      user_id = decode_token[0]['user_id']
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def authorize
    render json: {error: 'Unauthorized'}, status: :unauthorized unless current_user
  end
def record_not_found
  render json: {
    error: "Record not found"
  }, status: :not_found
end


end
