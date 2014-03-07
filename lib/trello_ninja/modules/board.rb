module TrelloNinja; module Modules; module Board
  def get_member_boards(member_id)
    collection = JSON(connection["/members/#{member_id}/boards"].get)
    collection.map { |object| TrelloNinja::Board.new.extend(TrelloNinja::Renderer::Board).from_json(object.to_json) }
  rescue Exception => e
    puts "Error: #{e.message}"
    []
  end
end; end; end