module Authentication
  extend ActiveSupport::Concern
  # included do
  #   before_action :authenticate_user
  # end
  included do
    helper_method :current_user
  end

  def current_user
    begin
      token = request.headers[:token]&.split(' ')&.last
      return unless token
      data = decode_data(token)
      user_id = data[0]['user_data']
      @current_user = User.find_by(id: user_id) if user_id.present?
    rescue StandardError => e  
      Rails.logger.error("An error occurred in current_user method: #{e.message}") 
      @current_user = nil      
    end
  end

  def encode_data(payload)
    payload[:exp] = 24.hours.from_now.to_i # Set expiry time to 24 hours from now
    token = JWT.encode payload, secret_key, "HS256"
    return token
  end
  
  def decode_data(token)
    begin
      data = JWT.decode token, secret_key, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end

  private

  def secret_key
    ENV['SECRET_KEY'] || "0babdbb27438e216543949aba81c29c0bb830ba79f628578f9254ad2088ee7c38dab31a31790aa747326c0a231c774093ce77eacb1d62d5ea57f1b5fe1a97346"
  end

  def authenticate_user
    unless current_user
      render json: { error: 'You are not authorized, please login' }, status: :unauthorized
    end
  end
end