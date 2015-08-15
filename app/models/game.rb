class Game < ActiveRecord::Base


  # validates_uniqueness_of :reference_id, scope: :user_id

  def self.search(game)
    @search = GiantBomb::Search.new
    # @search.limit(10)
    @search.offset(100)
    @search.resources('game')
    @search.query(game)


    return @search.fetch
  end

  # Creates a local copy of the Games based on it's ID from GiantBomb' API
  #
  def self.new_from_gb(id)
    data = {
      field_list: 'name'
    }

    game = GiantBomb::Game.detail(id, data)

    g = Game.new
    g.name = game.name
    g.description = game.deck
    g.reference_id = id
    g.user_id = User.first
    g.save

    Rails.logger.info game.deck
    # Rails.logger.info game['deck'].inspect
  end
end
