class Game < ActiveRecord::Base

  def self.search(game)
    @search = GiantBomb::Search.new
    @search.limit(10)
    @search.resources('game')
    @search.query(game)

    return @search.fetch
  end
end
