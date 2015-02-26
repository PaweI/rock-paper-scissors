class RockPaperScissors
  def winner(weapon1, weapon2)
    return 'draw' if weapon1 == weapon2
    return weapon1 if weapon1 == 'scissors' && weapon2 == 'paper'
    return weapon1 if weapon1 == 'rock' && weapon2 == 'scissors'
    return weapon1 if weapon1 == 'paper' && weapon2 == 'rock'
    return weapon2 if weapon2 == 'scissors' && weapon1 == 'paper'
    return weapon2 if weapon2 == 'rock' && weapon1 == 'scissors'
    return weapon2 if weapon2 == 'paper' && weapon1 == 'rock'
  end
end
