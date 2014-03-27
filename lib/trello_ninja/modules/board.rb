module TrelloNinja; module Modules; module Board
  def get_member_boards(member_id)
    collection = JSON(connection["/members/#{member_id}/boards"].get)
    collection.map { |object| TrelloNinja::Board.new.extend(TrelloNinja::Renderer::Board).from_json(object.to_json) }
  rescue Exception => e
    puts "Error: #{e.message}"
    []
  end

  def get_board(board_id)
    object = JSON(connection["/boards/#{board_id}"].get)
    TrelloNinja::Board.new.extend(TrelloNinja::Renderer::Board).from_hash(object)
  rescue Exception => e
    puts "Error: #{e.message}"
    nil
  end
end; end; end