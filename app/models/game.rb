class Game < ActiveRecord::Base

  serialize :themes
  serialize :developers
  serialize :release_platforms

  has_attached_file :cover, styles: {
    large:  '500x700>',
    medium: '200x300>',
    thumb:  '200x200>'
  },
  default_url: '/images/:style/missing.png'

  do_not_validate_attachment_file_type :cover

  validates_uniqueness_of :api_reference

  has_one :wiki

  has_many :collections
  has_many :users, through: :collections

  has_and_belongs_to_many :genres

  def to_param
    [id, name.parameterize].join('-')
  end

  def self.search(game)
    @search = GiantBomb::Search.new
    @search.offset(100)
    @search.limit(10)
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


    developers = []

    game.developers.each do |game_developer|
      developers << developer = { name: game_developer['name'], url: game_developer['site_detail_url'], api_reference: game_developer['id'] }
    end

    publishers = []

    game.publishers.each do |game_publisher|
      publishers << publisher = { name: game_publisher['name'], url: game_publisher['site_detail_url'], api_reference: game_publisher['id'] }
    end

    genres = []
    unless game.genres.nil?
      game.genres.each do |game_genre|

        genre = Genre.find_or_create_by(api_reference: game_genre['id']) do |genre|
          genre.name = game_genre['name']
          genre.url = game_genre['site_detail_url']
          genre.api_reference = game_genre['id']
        end

        genres << genre
      end
    end

    platforms = []
    game.platforms.each do |game_platform|
      platforms << platform = { name: game_platform['name'], abbr: game_platform['abbreviation'], url: game_platform['site_detail_url'], api_reference: game_platform['id'] }
    end

    themes = []

    unless game.themes.nil?
      game.themes.each do |game_theme|
        themes << theme = { name: game_theme['name'], url: game_theme['site_detail_url'], api_reference: game_theme['id'] }
      end
    end

    @game = Game.find_by_api_reference(game.id)

    if @game.nil?

      Rails.logger.info "the game does not exists!"

      gg = Game.new
      gg.name     = game.name
      gg.aliases  = game.aliases

      gg.genres     = genres
      gg.themes     = themes
      gg.developers = developers

      gg.description  = game.deck
      gg.cover        = game.image['super_url']
      gg.release_date = game.original_release_date

      gg.release_platforms = platforms
      gg.api_endpoint  = game.api_detail_url
      gg.api_reference = game.id

      gg.users        = [user]
      gg.save

      w = Wiki.find_or_create_by(game_id: gg.id) do |ww|

        ww.game_id = gg.id

        ww.body       = game.description
        ww.publishers = publishers
        ww.save
      end
    else
      Collection.create(user: user, game: @game)
    end
  end
end
