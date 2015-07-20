require 'open-uri'

class PlayerSeed

  def account_id_seed
    matches = Match.all
    matches.each do |match|
      match.payload["result"]["players"].each do |player|
        account_id = player["account_id"]
        Player.find_or_create_by(account_id: account_id)
      end
    end
    nil
  end

  def name_seed
    teams = Team.all
    teams.each do |team|
      team.id_roster.each do |account_id|
        counter = 0
        begin
          @file = Nokogiri::HTML(open("http://www.dotabuff.com/players/#{account_id}"))
        rescue OpenURI::HTTPError
          if counter > 10
            sleep 20
            retry
          else
            counter += 1
            sleep 10
            retry
          end
        end
        divs = @file.css("div[class='content-header-title']")
        name = divs.children[0].children[0].text
        player = Player.find_by account_id: account_id
        unless name.nil?
          player.update!(name: name)
        end
        sleep 5
      end
    end
  end
end
