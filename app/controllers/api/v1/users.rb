module Api
  module V1
    class Users < Grape::API
      resources :users do
        desc "User detail"
        get "/:uid" do
          user = User.find_by! uid: params[:uid]

          { id: user.uid, name: user.name, picture: user.picture }
        end
      end
    end
  end
end
