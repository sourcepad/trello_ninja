module TrelloNinja; module Modules; module Member
  def get_current_member
    object = JSON(connection["/tokens/#{token}/member"].get)
    TrelloNinja::Member.new.extend(TrelloNinja::Renderer::Member).from_hash(object)
  rescue Exception => e
    puts "Error: #{e.message}"
    nil
  end

  def get_member(member_id)
    object = JSON(connection["/members/#{member_id}"].get)
    TrelloNinja::Member.new.extend(TrelloNinja::Renderer::Member).from_hash(object)
  rescue Exception => e
    puts "Error: #{e.message}"
    nil
  end
end; end; end