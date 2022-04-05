module Errorhandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :notfound

    private

    def notfound(esception)
      logger.warn exception
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end