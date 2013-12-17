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
        board_info = JSON(connection["/boards/#{board_id}?key=#{key['client_id']}&token=#{token}"].get)
        actions = JSON(connection["/boards/#{board_id}/actions?key=#{key['client_id']}&token=#{token}"].get)
        cards = get_board_cards(board_id)
        members = get_board_members(board_id)
        new_actions = []
        actions.each do |action|
          new_actions << action_message(members, cards, action, board_info)
        end
        return new_actions.compact
      end

      def get_actions(board_id)
        actions = JSON(connection["/boards/#{board_id}/actions?key=#{key['client_id']}&token=#{token}"].get)
      end

      private

        def action_message(members, cards, action, board_info)
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
          
          # Do not include if just the position
          skip = true if action["type"] == "updateCard" && data["old"] && data["old"]["pos"]

          unless skip == true
            # Create card
            if action["type"] == "createCard"
              message = "#{author_fullname} added #{card_name} to #{data["list"]["name"]}"

            # Move card from old list to new list
            elsif action['type'] == "updateCard" && data["listAfter"] && data["listBefore"]
              message = "#{author_fullname} moved #{card_name} from #{data["listBefore"]["name"]} to #{data["listAfter"]["name"]}."

            # Update the name of a card
            elsif action["type"] == "updateCard" && data["old"] && data["old"]["name"]
              message = "#{author_fullname} renamed [#{data["old"]["name"]}] to  #{card_name}"

            # update description
            elsif action["type"] == "updateCard" && data["old"] && data["old"]["desc"]
              message = "#{author_fullname} updated the description of #{card_name}"  

            # archived card
            elsif action["type"] == "updateCard" && data["old"]
              if data["old"]["closed"] == true
                message = "#{author_fullname} un-archived #{card_name}"
              elsif data["old"]["closed"] == false
                message = "#{author_fullname} archived #{card_name}"
              end

            # Comment on card
            elsif action['type'] == "commentCard"
              message = "#{author_fullname} commented on #{card_name}: \"#{data["text"]}\""

            # Add a member to a card
            elsif action["type"] == "addMemberToCard"
              if action["memberCreator"]["id"] == action["member"]["id"]
                message = "#{author_fullname} joined #{card_name}"
              else
                message = "#{author_fullname} added #{member_fullname} to <a href='#{card_url}' target='_blank'>#{card_name}</a>"
              end          

            # Remove a member to a card
            elsif action["type"] == "removeMemberFromCard"
              if action["memberCreator"]["id"] == action["member"]["id"]
                message = "#{author_fullname} left #{card_name}"
              else
                message = "#{author_fullname} removed #{member_fullname} from #{card_name}"
              end
  
            # Update Board
            elsif action["type"] == "updateBoard"
              if data['board'] && data['board']['desc'] && data['old'] && data['old']['desc']
                message = "#{author_fullname} changed the description #{data["board"]["name"]}"              
              end

            # Add member to a board
            elsif action["type"] == "addMemberToBoard"
              added_member_object = members.detect { |member| member['id'] == data['idMemberAdded']}
              message = "#{author_fullname} added #{added_member_object.present? ? added_member_object['fullName'] : 'a member'} to #{data['board']['name']}."

            # Add Attachment to Card
            elsif action["type"] == "addAttachmentToCard"
              message = "#{author_fullname} attached #{data["attachment"]["name"]} to #{card_name}"            

            # Remove Attachment to Card
            elsif action["type"] == "deleteAttachmentFromCard"
              message = "#{author_fullname} removed #{data["attachment"]["name"]} from #{card_name}."            

            # added a checklist to card
            elsif action["type"] == "addChecklistToCard" && data['checklist'] && data['checklist']['name']
              message = "#{author_fullname} added #{data['checklist']['name']} checklist to #{card_name}."
          
            # Complete an item in the checklist of a card
            elsif action["type"] == "updateCheckItemStateOnCard" && data["checkItem"]["state"] == "complete"
              message = "#{author_fullname} completed #{data["checkItem"]["name"]} on #{card_name}." 

            # Remove checklist from card
            elsif action["type"] == "removeChecklistFromCard" && data['checklist'] && data['checklist']['name']
              message = "#{author_fullname} removed #{data['checklist']['name']} from #{card_name}."

            # move card to other board
            elsif action["type"] == "moveCardToBoard" && data["boardSource"]["name"] && data["card"]["name"]
              message = "#{author_fullname} transferred #{card_name} to #{data["boardSource"]["name"]}."

            # move card from other board
            elsif action["type"] == "moveCardFromBoard"
              message = "#{author_fullname} transferred #{card_name} from #{data["board"]["name"]} to #{data["boardTarget"]["name"]}."

            elsif action["type"] == "convertToCardFromCheckItem"
              cardSource_object = cards.detect { |card| card['id'] == data['cardSource']['id'] }
              card_object = cards.detect { |card| card['id'] == data["card"]["id"] }
              card_url = card_object['url'] if card_object
              message = "#{author_fullname} converted #{card_object["name"]} from a checklist item on #{cardSource_object["name"]}."
            end

            action['link'] = card_url
            action['message'] = message
            action['board_url'] = board_info['url']
          else
            action = nil
          end

          return action
        end
    end
  end
end