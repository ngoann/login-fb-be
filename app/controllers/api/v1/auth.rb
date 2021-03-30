module Api
  module V1
    class Auth < Grape::API
      resources :auth do
        desc "Login"
        params do
          requires :uid, type: String, allow_blank: false
          requires :name, type: String, allow_blank: false
          requires :picture, type: String, allow_blank: false
        end
        post "/login" do
          declared_params = declared(params)

          user = User.find_or_initialize_by uid: declared_params[:uid]

          user.assign_attributes declared_params
          user.save!
        end
      end
    end
  end
end
