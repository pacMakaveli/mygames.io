class Game < ActiveRecord::Base

  has_attached_file :cover, styles: {
    :medium => "300x300>",
    :thumb => "100x100>"
  }, :default_url => "/images/:style/missing.png"

  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
  validates_uniqueness_of :reference_id, scope: :user_id

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
    g.user_id = current_user
    g.save

    Rails.logger.info game.deck
    # Rails.logger.info game['deck'].inspect
  end
end
