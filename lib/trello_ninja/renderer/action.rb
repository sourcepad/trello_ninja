module TrelloNinja; module Renderer; module Action
  include Representable::JSON

  property :id
  property :member_creator_id, as: :idMemberCreator
  property :data, class: TrelloNinja::Data do
    property :board, class: TrelloNinja::Board, extend: Renderer::Board
    property :card, class: TrelloNinja::Card, extend: Renderer::Card
    property :list, class: TrelloNinja::List, extend: Renderer::List
    property :attachment, class: TrelloNinja::Attachment, extend: Renderer::Attachment
    property :text
    property :old
    property :member_id, as: :idMember
  end
  property :type
  property :date
  property :member_creator, class: TrelloNinja::Member, extend: Renderer::Member
  property :member, class: TrelloNinja::Member, extend: Renderer::Member
end; end; end