require "application_responder"

class ApplicationController < ActionController::Base
  include ErrorHandling
  self.responder = ApplicationResponder
  respond_to :html, :json

end
