class PlayersController < ApplicationController
  def show
    @player = Player.find_by("account_id = #{params[:id]}")
    @hero_list = HeroList.where("account_id = #{params[:id]}")
    counts = Hash.new(0)
    @hero_list.each { |hero_instance| counts[hero_instance.hero_id] += 1 }
    @fav_hero_id = counts.sort_by{|x,y| y}.last[0]
    HeroID::HERO_HASH[:result][:heroes].each do |hero|
      if @fav_hero_id == hero[:id]
        @fav_hero = hero[:name]
      end
    end
  end
end
