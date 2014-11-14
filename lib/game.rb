class Game

  attr_reader :player1, :player2

  def initialize
    @player1, @player2 = nil, nil
  end

  def add(player)
    player1 ? player2 = player : player1 = player unless has_two_players?
  end

  def has_two_players?
    return !@player1.nil? && !@player2.nil?
  end

end