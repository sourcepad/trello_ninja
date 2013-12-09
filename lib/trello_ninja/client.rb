require "trello_ninja/api"

module TrelloNinja
  class Client
    include TrelloNinja::Modules::Member
    include TrelloNinja::Modules::Board
    include TrelloNinja::Modules::Story

    attr_accessor :token, :key, :connections

    def initialize(key, token = nil)
      @key = key
      @token = token
    end

    def connection
      @connections ? @connections : (@connections = {})
      @connections[@token] ? @connections[@token] : new_connection
    end

    private

      def new_connection
        @connections[@token] = RestClient::Resource.new("https://api.trello.com#{api_path}")
      end

      def api_path
        '/1'
      end

  end
end