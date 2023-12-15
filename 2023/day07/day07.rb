class Day07
  attr_reader :lines

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)
  end


  def part_1
    hands = lines.map { |l| Hand.new l }.sort { |a, b| part_1_compare(b, a) }

    hands.each_with_index.map { |h, ndx| h.bet.to_i * (ndx + 1) }.sum
  end

  def part_2
    hands = lines.map { |l| Hand.new l }.sort { |a, b| part_2_compare(b, a) }

    hands.each_with_index.map { |h, ndx| h.bet.to_i * (ndx + 1) }.sum
  end

  def part_1_compare a, b
    return a.type_index <=> b.type_index if a.type != b.type

    a.card_indices <=> b.card_indices
  end

  def part_2_compare a, b
    return a.j_type_index <=> b.j_type_index if a.j_type != b.j_type

    a.j_card_indices <=> b.j_card_indices
  end
end

class Hand
  attr_reader :cards, :bet

  TYPES = %i(five_of_a_kind four_of_a_kind full_house three_of_a_kind two_pair one_pair high_card)
  CARDS = %w(A K Q J T 9 8 7 6 5 4 3 2 j)

  def initialize line
    @cards, bet_str = line.split ' '
    @bet = bet_str.to_i
  end

  def grouping
    @grouping ||= cards.chars.group_by(&:itself).map { |k, v| v.length }.sort.reverse
  end

  def type
    @type ||= begin
                case grouping
                when [5]
                  :five_of_a_kind
                when [4, 1]
                  :four_of_a_kind
                when [3, 2]
                  :full_house
                when [3, 1, 1]
                  :three_of_a_kind
                when [2, 2, 1]
                  :two_pair
                when [2, 1, 1, 1]
                  :one_pair
                else
                  :high_card
                end
              end
  end

  # Types under part_2 (J) rules
  # Five of a kind -> unchanged
  # Four of a kind -> five of a kind
  # Full house -> five of a kind
  # Three of a kind -> four of a kind
  # Two pair
  #   If two Js -> four of a find
  #   If one J -> full house
  # One pair -> three of a kind
  # High card -> one pair
  def j_type
    t = type
    return t unless cards.match? /J/

    return :five_of_a_kind if type_index < 3

    if t == :two_pair
      return cards.count('J') == 2 ? :four_of_a_kind : :full_house
    end

    case t
    when :three_of_a_kind
      :four_of_a_kind
    when :one_pair
      :three_of_a_kind
    else
      :one_pair
    end
  end

  def type_index
    TYPES.index(type)
  end

  def j_type_index
    TYPES.index(j_type)
  end

  def card_indices
    cards.chars.map { |c| CARDS.index(c) }
  end

  def j_card_indices
    cards.gsub(/J/, 'j').chars.map { |c| CARDS.index(c) }
  end
end
