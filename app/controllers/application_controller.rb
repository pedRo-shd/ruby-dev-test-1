require "application_responder"

class ApplicationController < ActionController::Base
  include ErrorHandling unless Rails.env.test?
  self.responder = ApplicationResponder
  respond_to :html, :json

end
