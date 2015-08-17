class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, only: [:new, :create, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  def search
    @games = Game.search(params[:query])
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_from_gb
    # Game.new_from_gb(params[:game], current_user)


    Struct.new('Developers', :name, :url, :reference_id )
    Struct.new('Genres', :name, :url, :reference_id )
    Struct.new('Platforms', :name, :abbreviation, :url, :reference_id )
    # Struct.new('Developers', :name, :url)
    # Struct.new('Developers', :name, :url)
    # Struct.new('Developers', :name, :url)

    data = {
      field_list: 'name'
    }

    game = GiantBomb::Game.detail(params[:game], data)

    developers = []

    game.developers.each do |d|
      developers << Struct::Developers.new(d['name'], d['site_detail_url'], d['id'])
    end

    genres = []
    game.genres.each do |g|
      genres << Struct::Genres.new(g['name'], g['site_detail_url'], g['id'])
    end

    platforms = []
    game.platforms.each do |p|
      platforms << Struct::Platforms.new(p['name'], p['abbreviation'], p['site_detail_url'], p['id'])
    end

    # Game
    #
    g = Game.new

    g.name        = game.name
    # g.aliases     = game.aliases
    # g.developers  = developers

    g.description = game.deck
    g.cover       = game.image['super_url']
    g.platform    = game.platforms

    g.reference_id = game.id
    g.users        = [current_user.id]
    # g.save

    @game = []
    @game << game
    # @game << genres

    # Game Wiki
    #
    w = Wiki.new

    w.game_id = g.id

    w.genre        = game.genres
    w.body         = game.description
    w.theme        = game.themes
    w.release_date = game.original_release_date
    # w.save

    # @game << w

    render json: @game
  end

private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(
      :name,
      :aliases,
      :description,
      :endpoint,
      :cover,
      user_ids: []
    )
  end
end
