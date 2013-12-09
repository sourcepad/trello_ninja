module TrelloNinja
	module Modules
		module Board
      def get_board_cards(board_id)
        JSON(connection["/boards/#{board_id}/cards?key=#{key['client_id']}&token=#{token}"].get)
      end

      def get_board_lists(board_id)
        JSON(connection["/boards/#{board_id}/lists?key=#{key['client_id']}&token=#{token}"].get)
      end

      def get_board_members(board_id)
        JSON(connection["/boards/#{board_id}/members?key=#{key['client_id']}&token=#{token}"].get)
      end

      def get_board_actions(board_id)
        actions = JSON(connection["/boards/#{board_id}/actions?limit=10&key=#{key['client_id']}&token=#{token}"].get)
        cards = get_board_cards(board_id)
        members = get_board_members(board_id)
        new_actions = []
        actions.each do |action|
          new_actions << action_message(members, cards, action)
        end
        return new_actions				
      end

      private

        def action_message(members, cards, action)
          data = action['data']
          if data && data['card']
          	card_id = data['card']['id']
          	card_name = data['card']['name']
          	card_object = cards.detect { |card| card['id'] == data['card']['id'] }
          end
          card_url = card_object['url'] if card_object
          author_fullname = action['memberCreator']['fullName'] if action && action['memberCreator']
          author_username = action['memberCreator']['username'] if action && action['memberCreator']
          member_fullname = action["member"]["fullName"] if action["member"]
          
          
          # Create card
          if action["type"] == "createCard"
            message = "#{author_fullname} added <a href='#{card_url}' target='_blank'>#{card_name}</a> to #{data["list"]["name"]}"

          # Move card from old list to new list
          elsif action['type'] == "updateCard" && data["listAfter"] && data["listBefore"]
            url = card_url.present? ? "<a href='#{card_url}' target='_blank'>#{card_name}</a>" : "#{card_name}"
            message = "#{author_fullname} moved #{url} from #{data["listBefore"]["name"]} to #{data["listAfter"]["name"]}."

          # Update the name of a card
          elsif action["type"] == "updateCard" && data["old"] && data["old"]["name"]
            message = "#{author_fullname} renamed [#{data["old"]["name"]}] to  <a href='#{card_url}' target='_blank'>#{card_name}</a>"

          # archived card
          elsif action["type"] == "updateCard" && data["old"]
            if data["old"]["closed"] == true
              message = "#{author_fullname} un-archived  <a href='#{card_url}' target='_blank'>#{card_name}</a>"
            elsif data["old"]["closed"] == false
              message = "#{author_fullname} archived #{card_name}"
            end

          elsif action["type"] == "updateCard" && data["old"] && data["old"]["desc"]
            message = "#{author_fullname} updated the description of <a href='#{card_url}' target='_blank'>#{card_name}</a>"            

          # Comment on card
          elsif action['type'] == "commentCard"
            message = "#{author_fullname} commented on <a href='#{card_url}' target='_blank'>#{card_name}</a>: \"#{data["text"]}\""

          # Add a member to a card
          elsif action["type"] == "addMemberToCard"
            if action["memberCreator"]["id"] == action["member"]["id"]
              message = "#{author_fullname} joined <a href='#{card_url}' target='_blank'>#{card_name}</a>"
            else
              message = "#{author_fullname} added #{member_fullname} to <a href='#{card_url}' target='_blank'>#{card_name}</a>"
            end          

          # Remove a member to a card
          elsif action["type"] == "removeMemberFromCard"
            if action["memberCreator"]["id"] == action["member"]["id"]
              message = "#{author_fullname} left <a href='#{card_url}' target='_blank'>#{card_name}</a>"
            else
              message = "#{author_fullname} removed #{member_fullname} from <a href='#{card_url}' target='_blank'>#{card_name}</a>"
            end

          elsif action["type"] == "addMemberToBoard"
            begin
              added_member_object = members.detect { |member| member['id'] == data['idMemberAdded']}
              message = "#{author_fullname} added #{added_member_object.present? ? added_member_object['fullName'] : 'a member'} to #{data['board']['name']}"
            rescue
              binding.pry
            end

          # Complete an item in the checklist of a card
          elsif action["type"] == "updateCheckItemStateOnCard" && data["checkItem"]["state"] == "complete"
            message = "#{author_fullname} completed #{data["checkItem"]["name"]} on <a href='#{card_url}' target='_blank'>#{card_name}</a>"            
          end
          
          action['link'] = card_url
          action['message'] = message
          return action
        end
    end
  end
end