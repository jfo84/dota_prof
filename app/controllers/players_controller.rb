class PlayersController < ApplicationController
  def show
    @player = Player.find_by("account_id = #{params[:id]}")
    current_list = HeroList.where("account_id = :account_id and start_time > :start_time", account_id: params[:id], start_time: 1430395200)
    User.where(["name = :name and email = :email", { name: "Joe", email: "joe@example.com" }])
    counts = Hash.new(0)
    current_list.each { |hero_instance| counts[hero_instance.hero_id] += 1 }
    binding.pry
    @fav_hero_id = counts.sort_by{|x,y| y}.last[0]
    HeroID::HERO_HASH[:result][:heroes].each do |hero|
      if @fav_hero_id == hero[:id]
        @fav_hero = hero[:name]
      end
    end
  end
end

=begin

6.84 began @ 1430395200
6.83 @ 1418817600
6.82 @ 1411560000

=end
