module Hexapic
  module API
    class Instagram
      INSTAGRAM_API_URL = 'https://api.instagram.com/v1/'

      def initialize(client_id)
        @client_id = client_id
        @conn = Faraday.new(url: INSTAGRAM_API_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter :net_http
        end
      end

      def search(tag, count = 20)
        tag = URI.encode(tag)
        res = @conn.get("tags/#{tag}/media/recent",{client_id: @client_id, count: count})
        data = JSON.parse(res.body)
        
        data['data'].map do |img|
          {
            id: img['id'], 
            likes: img['likes']['count'], 
            link: img['link'], 
            url: img['images']['standard_resolution']['url']
          }
        end
      end
    end
  end
end