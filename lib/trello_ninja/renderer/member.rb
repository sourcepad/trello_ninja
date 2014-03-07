module TrelloNinja; module Renderer; module Member
  include Representable::JSON

  property :id
  property :avatar_hash, as: :avatarHash
  property :bio
  property :bio_data, as: :bioData
  property :confirmed
  property :full_name, as: :fullName
  property :premium_organizations_admin_id, as: :idPremOrgsAdmin
  property :initials
  property :member_type, as: :memberType
  property :products
  property :status
  property :url
  property :username
  property :avatar_source, as: :avatarSource
  property :email, as: :email
  property :gravatar_hash, as: :gravatarHash
  property :boards_id, as: :idBoards
  property :invited_boards_id, as: :idBoardsInvited
  property :pinned_boards_id, as: :idBoardsPinned
  property :organizations_id, as: :idOrganizations
  property :invited_organizations_id, as: :idOrganizationsInvited
  property :login_types, as: :loginTypes
  property :new_email, as: :newEmail
  property :one_time_messages_dismissed, as: :oneTimeMessagesDismissed
  property :preferences, as: :prefs
  property :trophies
  property :uploaded_avatar_hash, as: :uploadedAvatarHash
  property :premium_features, as: :premiumFeatures
end; end; end