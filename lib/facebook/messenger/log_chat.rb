
class LogChat2
  include SuckerPunch::Job

  def perform(message, type, api_ai_response)
    ActiveRecord::Base.connection_pool.with_connection do
      #log dashbot
      if type == 'deliver'
        uri = URI.parse("https://tracker.dashbot.io/track?platform=facebook&v=9.2.0-rest&type=outgoing&apiKey=#{ENV['DASHBOT_KEY']}")
      else
        uri = URI.parse("https://tracker.dashbot.io/track?platform=facebook&v=9.2.0-rest&type=incoming&apiKey=#{ENV['DASHBOT_KEY']}")
      end
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json; charset=utf-8"
      request.body = message.to_json
      req_options = {
        use_ssl: uri.scheme == "https",
        verify_mode: OpenSSL::SSL::VERIFY_NONE,
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end
  end

end