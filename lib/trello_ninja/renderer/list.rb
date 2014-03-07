module TrelloNinja; module Renderer; module List
  include Representable::JSON

  property :id
  property :name
  property :closed
  property :board_id, as: :idBoard
  property :pos
  property :subscribed
end; end; end