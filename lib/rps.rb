require 'sinatra/base'
require_relative 'game'
require_relative 'player'

class RockPapepScissors < Sinatra::Base

  GAME = Game.new

  PLAYERS = []

  set :views, Proc.new { File.join(root, '..', 'views') }

  enable :sessions

  get '/' do
    # @player1 = GAME.player1
    # @player2 = GAME.player2
    # # p '===' * 30
    # # p session
    # # p '===' * 30
    # # p GAME
    erb :index
  end

  post '/' do
    player = Player.new(params[:name])
    # session[:game] = GAME
    if GAME.player1.nil?
      GAME.add(player)
      PLAYERS << session["session_id"]
    elsif GAME.player2.nil? && PLAYERS.first != session["session_id"]
      GAME.add(player)
      PLAYERS = session["session_id"]
    end
    p '===' * 30
    p session
    p'===' * 30
    p GAME
    erb :wait
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
