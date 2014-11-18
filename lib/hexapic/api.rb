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

      def search_by_user(username, count = 100)
        user_media(search_user(username), count)
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
            url: img['images']['standard_resolution']['url'],
            width: img['images']['standard_resolution']['width'],
            height: img['images']['standard_resolution']['height']
          }
        end
      end

      def user_media(user_id, count)
        res = @conn.get("users/#{user_id}/media/recent/", {client_id: @client_id, count: count})
        data = JSON.parse(res.body)['data']

        data.map do |img|
          {
            id: img['id'],
            likes: img['likes']['count'],
            link: img['link'],
            url: img['images']['standard_resolution']['url'],
            width: img['images']['standard_resolution']['width'],
            height: img['images']['standard_resolution']['height']
          }
        end
      end

      def search_user(username)
        puts "Searching user #{username}"
        username = URI.encode(username)
        res = @conn.get("users/search", {q: username, client_id: @client_id})
        data = JSON.parse(res.body)['data'].first
        raise UserNotFound.new("User with name #{username} not found") if data.nil?
        puts "Find user #{data['username']} #{data['first_name']} #{data['last_name']} with id #{data['id']}"

        data['id']
      end
    end
  end
end