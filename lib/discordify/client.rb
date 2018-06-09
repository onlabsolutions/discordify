# frozen_string_literal: true

module Discordify
  class Client

    attr_accessor :webhook_address

    class << self

      attr_accessor :webhook_address

    end

    def initialize(webhook_address = nil)
      @webhook_address = webhook_address || self.class.webhook_address
    end

    def post_json(message:, username:, avatar:)
      avatar ||= default_avatar
      url = uri(webhook_address)
      request = Net::HTTP::Post.new(url.path, headers)
      request.body = { content: message, username: username, avatar_url: avatar }.to_json
      res = https_request(url).request(request)

      res.code == '204'
    end

    private

    def uri(url)
      URI.parse(URI.escape(url))
    end

    def https_request(uri)
      Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl = true
      end
    end

    def headers
      { 'Content-Type' => 'application/json' }
    end

    def default_avatar
      'http://www.gravatar.com/avatar/?d=identicon'
    end

  end
end
