class Player
  attr_reader :name
  attr_accessor :player_cards


  def initialize(name, player_cards = [])
    @name = name
    @player_cards = player_cards
  end

  def place_card
    @player_cards.shift
  end

  def recieve_cards(pile)
    @player_cards.concat(pile)
  end

  def lose?(other_player)
    if self.player_cards.empty?
      puts "#{self.name} has lost; #{other_player.name} has won!"
      exit
    end
    false
  end

end
