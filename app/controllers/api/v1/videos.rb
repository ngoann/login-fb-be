module Api
  module V1
    class Videos < Grape::API
      resources :videos do
        desc "Create videos"
        params do
          requires :name, type: String
          requires :content, type: String
        end
        post "/" do
          splited_contents = params[:content].split("\n").reject &:blank?

          { splited_contents: splited_contents }
        end
      end
    end
  end
end
