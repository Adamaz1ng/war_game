require_relative 'card'

# Represents a deck of playing cards.
class Deck
  attr_reader :cards
  # Returns an array of all 52 playing cards.
  def self.all_cards
    res = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        res << Card.new(suit, value)
      end
    end
    res
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  def empty?
    count == 0
  end

  # Takes `n` cards from the top of the deck (front of the cards array).
  def take(n)
    @cards.shift(n)
  end

end
