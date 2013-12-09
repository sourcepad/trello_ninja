module TrelloNinja
  module Modules
    module Member
      def get_current_person
        JSON(connection["/tokens/#{token}/member?key=#{key['client_id']}"].get)
      end	

      def get_member_boards(member_id)
      	JSON(connection["/members/#{member_id}/boards?key=#{key['client_id']}&token=#{token}"].get)
      end
    end
  end
end