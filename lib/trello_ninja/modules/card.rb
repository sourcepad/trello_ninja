module TrelloNinja; module Modules; module Card
  def get_board_cards(board_id)
    collection = JSON(connection["/boards/#{board_id}/cards"].get)
    collection.map { |object| TrelloNinja::Card.new.extend(TrelloNinja::Renderer::Card).from_json(object.to_json) }
  rescue Exception => e
    puts "Error: #{e.message}"
    []
  end
end; end; end