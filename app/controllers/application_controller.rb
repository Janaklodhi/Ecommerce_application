class ApplicationController < ActionController::Base
 # protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.include? 'application/json' }
end