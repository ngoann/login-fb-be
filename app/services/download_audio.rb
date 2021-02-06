require 'net/http'

class DownloadAudio
  AUDIO_URL = "http://readspeaker.jp/ASLCLCLVVS/JMEJSYGDCHMSMHSRKPJL"

  attr_reader :video_id, :text

  def initialize video_id, text
    @text = text
    @video_id = video_id
  end

  def perform
    splited_texts = text.split("\n").reject &:blank?

    splited_texts.each_with_index do |_text, index|
      params = {
        text: _text,
        talkID: 358,
        volume: 100,
        speed: 100,
        pitch: 100,
        feeling: 2,
        dict: 3
      }

      uri = URI "https://readspeaker.jp/tomcat/servlet/vt"

      request = Net::HTTP::Post.new uri.path
      request.set_form params

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      response = http.request request

      audio_name = response.body.squish.gsub "comp=", ""

      tempfile = Down.download "#{AUDIO_URL}/#{audio_name}"

      directory_name = "public/#{video_id}/audios"

      FileUtils.mkdir_p(directory_name) unless File.exists?(directory_name)

      FileUtils.mv tempfile.path, "#{directory_name}/audio_#{index}.mp3"
    end

    video_id
  rescue
    false
  end
end
