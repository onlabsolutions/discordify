# frozen_string_literal: true

module Discordify
  class << self

    def push_message(avatar, username, content, webhook = nil)
      client(webhook).post_json(user: username, message: content, avatar: avatar)
    end

    def push_message_async(avatar, username, content, webhook = nil)
      Thread.start do
        push_message(avatar, username, content, webhook)
      end
    end

    private

    def client(webhook = nil)
      Discordify::Client.new(webhook)
    end

  end
end
