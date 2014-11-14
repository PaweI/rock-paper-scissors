require 'sinatra/base'
require_relative 'game'
require_relative 'player'

class RockPapepScissors < Sinatra::Base

  GAME = Game.new

  set :views, Proc.new { File.join(root, '..', 'views') }

  enable :sessions

  get '/' do
    @player1 = GAME.player1
    @player2 = GAME.player2
    p '===' * 30
    p session
    p '===' * 30
    p GAME
    erb :index
  end

  post '/' do
    player = Player.new(params[:name])
    # session[:game] = GAME
    session[:me]=player.object_id
    if GAME.player1.nil?
      GAME.add(player)
    elsif GAME.player2.nil?
      GAME.add(player) if session[:me] != GAME.player1.object_id
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
