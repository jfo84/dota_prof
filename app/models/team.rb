class Team < ActiveRecord::Base
  has_many :players
  has_many :matches

  validates :name, presence: true

  def self.teams
    Team.where("rank <= 25").order(rank: :asc)
  end

  def self.team_ids
    teams.map { |team| team.team_id }
  end

  def self.team_matches
    team_ids.map { |team_id| TeamMatch.where(team_id: team_id) }
  end

  def self.captain_list
    @captain_list = []
    team_matches.each do |team_matches_by_team|
      @captain_counts = Hash.new(0)
      team_matches_by_team.each do |team_match|
        @captain_counts[team_match.captain_id] += 1
      end
      @captain_counts.delete_if{|k, v| k.nil? }
      @captain_list << @captain_counts.sort_by{|k, v| -v}
    end
    @captain_list
  end

  def self.win_list
    @win_list = []
    team_matches.each do |team_matches_by_team|
      @win_counts = Hash.new(0)
      team_matches_by_team.each do |team_match|
        if team_match.radiant == true && team_match.radiant_win == true
          @win_counts[team_match.captain_id] += 1
        elsif team_match.radiant == false && team_match.radiant_win == false
          @win_counts[team_match.captain_id] += 1
        end
      end
      @win_counts.delete_if{|k, v| k.nil? }
      @win_list << @win_counts.sort_by{|k, v| -v}
    end
    @win_list
  end

  def self.pick_list
    @pick_list = []
    team_matches.each do |team_matches_by_team|
      @pick_counts = Hash.new(0)
      team_matches_by_team.each do |team_match|
        unless team_match.picks.nil? && team_match.bans.nil?
          team_match.picks.each do |hero_id|
            @pick_counts[hero_id] += 1
          end
        end
      end
      @pick_list << @pick_counts.sort_by{|k, v| -v}
    end
    @pick_list
  end

  def self.ban_list
    @ban_list = []
    team_matches.each do |team_matches_by_team|
      @ban_counts = Hash.new(0)
      team_matches_by_team.each do |team_match|
        unless team_match.bans.nil? && team_match.bans.nil?
          team_match.bans.each do |hero_id|
            @ban_counts[hero_id] += 1
          end
        end
      end
      @ban_list << @ban_counts.sort_by{|k, v| -v}
    end
    @ban_list
  end
end
