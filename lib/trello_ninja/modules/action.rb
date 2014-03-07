module TrelloNinja; module Modules; module Action
  def get_board_actions(board_id)
    collection = JSON(connection["/boards/#{board_id}/actions"].get)
    collection.map { |object| TrelloNinja::Action.new.extend(TrelloNinja::Renderer::Action).from_json(object.to_json) }
  rescue Exception => e
    puts "Error: #{e.message}"
    []
  end
end; end; end