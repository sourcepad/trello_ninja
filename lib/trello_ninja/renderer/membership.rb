module TrelloNinja; module Renderer; module Membership
  include Representable::JSON

  property :id
  property :member_id, as: :idMember
  property :deactivated
  property :unconfirmed
end; end; end