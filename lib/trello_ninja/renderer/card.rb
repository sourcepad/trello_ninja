module TrelloNinja; module Renderer; module Card
  include Representable::JSON

  property :id
  property :check_item_states, as: :checkItemStates
  property :closed
  property :date_last_activity, as: :dateLastActivity
  property :description, as: :desc
  property :description_data, as: :descData
  property :board_id, as: :idBoard
  property :list_id, as: :idList
  property :members_voted_id, as: :idMembersVoted
  property :short_id, as: :idShort
  property :attachment_cover_id, as: :idAttachmentCover
  property :manual_cover_attachment, as: :manualCoverAttachment
  property :name
  property :pos
  property :short_link, as: :shortLink
  property :badges
  property :due
  property :checklists_id, as: :idChecklists
  property :members_id, as: :idMembers
  property :labels
  property :short_url, as: :shortUrl
  property :subscribed
  property :url
end; end; end