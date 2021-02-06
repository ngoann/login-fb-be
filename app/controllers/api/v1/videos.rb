module Api
  module V1
    class Videos < Grape::API
      resources :videos do
        desc "Create videos"
        params do
          requires :title, type: String
          requires :text, type: String
        end
        post "/" do
          video_id = SecureRandom.hex

          if DownloadAudio.new(video_id, params[:text]).perform
            
          end

          { video_id: video_id }
        end
      end
    end
  end
end
