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

  has_many :collections
  has_many :users, through: :collections

  has_and_belongs_to_many :genres

  def to_param
    [id, name.parameterize].join('-')
  end

  def self.search(game)
    @search = GiantBomb::Search.new
    # @search.offset(100)
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

    puts game.inspect

    # Game
    #
    g = Game.new

    g.name        = game.name
    g.description = game.deck
    g.cover       = game.image['super_url']
    g.platform    = game.platforms

    g.reference_id = game.id
    g.user_id      = user.id
    # g.save

    puts g

    # Game Wiki
    #
    w = Wiki.new

    w.game_id = g.id

    w.genre        = game.genres
    w.body         = game.description
    w.theme        = game.themes
    w.release_date = game.original_release_date
    # w.save

    puts w
  end
end
