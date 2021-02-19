module Repository
  class Discord
    def initialize(@url : String)
      @uri = URI.parse @url
    end

    def send_post(post)
      res = HTTP::Client.post(@uri,
        headers: HTTP::Headers{"Content-Type" => "application/json"},
        body: post.to_json
      )

      res.body
    end
  end
end
