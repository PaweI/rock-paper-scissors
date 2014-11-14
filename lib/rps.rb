require 'sinatra/base'
require_relative 'game'
require_relative 'player'

class RockPapepScissors < Sinatra::Base

  GAME = Game.new

  PLAYERS = []

  set :views, Proc.new { File.join(root, '..', 'views') }

  set :public_folder, 'public'

  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    player = Player.new(params[:name])
    if GAME.player1.nil?
      GAME.add(player)
      PLAYERS << session["session_id"]
      return erb :wait
    elsif GAME.player2.nil? && PLAYERS.first != session["session_id"]
      GAME.add(player)
      PLAYERS = session["session_id"]
      return erb :game
    end
    return erb :game if GAME.has_two_players?
  end

  post '/winner' do
    p params
    erb :winner
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
