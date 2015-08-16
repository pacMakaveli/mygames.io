class Game < ActiveRecord::Base

  has_attached_file :cover, styles: {
    large:  '500x700',
    medium: '200x300>',
    thumb:  '200x200>'
  },
  # path: ':rails_root/public/images/:id/:style/:filename',
  default_url: '/images/:style/missing.png'

  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
  validates_uniqueness_of :reference_id, scope: :user_id

  has_one :wiki

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
  def self.new_from_gb(id, user)
    data = {
      field_list: 'name'
    }

    game = GiantBomb::Game.detail(id, data)

    g = Game.new
    g.name = game.name
    g.description = game.deck
    g.reference_id = id
    g.cover = game.image['super_url']
    g.user_id = user.id
    g.save

    Rails.logger.info user
    # Rails.logger.info game['deck'].inspect
  end
end
