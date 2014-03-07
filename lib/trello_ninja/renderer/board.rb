module TrelloNinja; module Renderer; module Board
  include Representable::JSON

  property :id
  property :name
  property :description, as: :desc
  property :description_data, as: :descData
  property :closed
  property :organization_id, as: :idOrganization
  property :invited
  property :pinned
  property :starred
  property :url
  property :preferences, as: :prefs
  property :invitations
  collection :memberships, class: TrelloNinja::Membership, extend: Renderer::Membership
  property :short_link, as: :shortLink
  property :subscribed
  property :label_names, as: :labelNames
  property :power_ups, as: :powerUps
  property :last_activity_at, as: :dateLastActivity
  property :last_viewed_at, as: :dateLastView
  property :short_url, as: :shortUrl
end; end; end