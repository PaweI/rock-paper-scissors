require 'sinatra/base'
require_relative 'game'
require_relative 'player'
require_relative 'rock-paper-scissors'

class RockPapepScissors < Sinatra::Base
  GAME = Game.new

  PLAYERS = []

  ENGINE = RockPaperScissors.new

  WEAPON1 = nil

  WEAPON2 = nil

  DECISION = nil

  set :views, proc { File.join(root, '..', 'views') }

  set :public_folder, 'public'

  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    player = Player.new(params[:name])
    if GAME.player1.nil?
      GAME.add(player)
      PLAYERS << session['session_id']
      return erb :wait
    elsif GAME.player2.nil? && PLAYERS.first != session['session_id']
      GAME.add(player)
      PLAYERS << session['session_id']
      return erb :game
    end
    return erb :game if GAME.has_two_players?
  end

  post '/decision' do
    WEAPON1 = params[:weapon] if PLAYERS[0] == session['session_id']
    WEAPON2 = params[:weapon] if PLAYERS[1] == session['session_id']
    if WEAPON1 && WEAPON2
      redirect '/winner'
    end
  end

  get '/winner' do
    DECISION = ENGINE.winner(WEAPON1, WEAPON2)
    erb :winner
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
