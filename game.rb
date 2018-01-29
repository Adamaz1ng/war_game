require_relative 'deck'
require_relative 'player'
require 'byebug'

class Game
  attr_accessor :pile
  attr_reader :player1, :player2, :on_war

  def self.setup_game
    deck = Deck.new
    player1 = Player.new("Rick")
    player2 = Player.new("Morty")
    deck.cards.each_with_index do |card, idx|
      idx.even? ? player1.player_cards << card : player2.player_cards << card
    end
    Game.new(player1, player2)
  end

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @pile = []
    @on_war = false
    play
  end

  def play
    until game_over?(player1, player2)
      render
      @pile.concat([player1.place_card.switch_face])
      @pile.concat([player2.place_card.switch_face])
      if is_equal?
        war
      end
      @pile.each do |card|
        card.face_up = false
      end
      render
      if @pile[-2].card_ranking > @pile[-1].card_ranking
        player1.recieve_cards(pile)
      else
        player2.recieve_cards(pile)
      end
      @pile = []
    end
  end

  def game_over?(player1, player2)
    player1.lose?(player2)
    player2.lose?(player1)
    false
  end

  def is_equal?
    return true if @pile[-2].card_ranking == @pile[-1].card_ranking
    false
  end

  def war
    @on_war = true
    render
    until !is_equal? || game_over?(player1, player2)
      @pile.concat([player1.place_card])
      @pile.concat([player2.place_card])
      game_over?(player1, player2)
      render
      @pile.concat([player1.place_card.switch_face])
      @pile.concat([player2.place_card.switch_face])
    end
    @on_war = false
  end

  def render
    system 'clear'
    puts "#{player1.name} has: #{player1.player_cards.count} cards"
    puts "#{player2.name} has: #{player2.player_cards.count} cards"
    puts "There are #{pile.count} cards in the pile"
    puts "War is on!" if @on_war
    sleep(0.25)
  end

  if __FILE__ == $PROGRAM_NAME
    Game.setup_game
  end

end
