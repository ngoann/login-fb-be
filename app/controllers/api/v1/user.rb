module Api
  module V1
    class User < Grape::API
      resources :user do
        desc "User detail"
        get "/" do
          user = ::User.first

          { id: user.uid, name: user.name, picture: user.picture }
        end
      end
    end
  end
end
