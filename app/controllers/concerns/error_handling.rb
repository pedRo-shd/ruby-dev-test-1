module ErrorHandling
  extend ActiveSupport::Concern

  def self.included(clazz)
    clazz.class_eval do
      rescue_from StandardError do |error|
        standard_error(error)
      end
    end
  end

  def standard_error(error)
    flash[:alert] = error
    redirect_to request.referer || root_path
  end
end
