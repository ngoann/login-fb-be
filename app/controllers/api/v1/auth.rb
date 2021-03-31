module Api
  module V1
    class Auth < Grape::API
      resources :auth do
        desc "Login"
        params do
          requires :access_token, type: String, allow_blank: false
        end
        post "/login" do
          expected_fields = "id,name,picture.type(large)"

          response = FaradayService.get(
            'https://graph.facebook.com/me',
            access_token: params[:access_token],
            fields: expected_fields
          ).body

          response_with_json = JSON::parse response

          unless response_with_json["error"]
            user = ::User.find_or_initialize_by uid: response_with_json["id"]

            user.assign_attributes(
              name: response_with_json["name"],
              picture: response_with_json["picture"]["data"]["url"]
            )

            user.save!

            { access_token: user.uid }
          end
        end
      end
    end
  end
end
