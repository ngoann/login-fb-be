module Api
  module V1
    class Root < Grape::API
      prefix :api
      version :v1
      format :json

      mount Videos
    end
  end
end
