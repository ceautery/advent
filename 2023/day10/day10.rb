class Day10
  require 'set'

  attr_reader :hash, :s, :w, :h, :main_loop

  # UNI = { 'F' => '┌', '-' => '─', '7' => '┐', '|' => '│', 'L' => '└', 'J' => '┘' }
  #  I used the above for visualization when I was stumped.
  #
  # ...........    ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅
  # .S-------7.    ⋅S───────┐⋅
  # .|F-----7|.    ⋅│┌─────┐│⋅
  # .||.....||.    ⋅││⋅⋅⋅⋅⋅││⋅
  # .||.....||. => ⋅││⋅⋅⋅⋅⋅││⋅
  # .|L-7.F-J|.    ⋅│└─┐⋅┌─┘│⋅
  # .|..|.|..|.    ⋅│II│⋅│II│⋅
  # .L--J.L--J.    ⋅└──┘⋅└──┘⋅
  # ...........    ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅

  def initialize
    # Parse input into AofA of characters
    grid = File.read('input.txt').chomp.split(/\n/).map(&:chars)
    @h = grid.length
    @w = grid.first.length

    # Build nodes flat array with coords and character
    @hash = {}
    grid.each_with_index do |arr, y|
      arr.each_with_index do |c, x|
        hash["#{x},#{y}"] = Node.new(x, y, c)
      end
    end

    nodes = hash.values

    # Find and set connected nodes
    nodes.each { |n| set_connections n }

    @s  = nodes.find { |n| n.c == 'S' }
    s.connected = nodes.select { |n| n.connected&.include? s }.sort { |n1, n2| (n1.x <=> n2.x) || (n1.y <=> n2.y) }

    # Figure out what S's real character should have been
    s.c = s.real_char_for_s

    # Set flag for all pipes that are in loop containing S
    s.in_loop = true
    set_loop
  end

  def node x, y
    hash["#{x},#{y}"]
  end

  def set_connections node
    return if node.c == '.' or node.c == 'S'

    x, y = [node.x, node.y]
    coords = case node.c
             when '|'
               [[x, y - 1], [x, y + 1]]
             when '-'
               [[x - 1, y], [x + 1, y]]
             when 'L'
               [[x, y - 1], [x + 1, y]]
             when 'J'
               [[x, y - 1], [x - 1, y]]
             when 'F'
               [[x + 1, y], [x, y + 1]]
             when '7'
               [[x - 1, y], [x, y + 1]]
             end

    node.connected = coords.map { |cs| node(*cs) }.compact
  end

  def next_node prev, node
    node.connected.find { |n| n != prev }
  end

  def set_loop
    @main_loop = [s]
    prev = s
    node = s.connected.first
    until node == s
      main_loop << node
      node.in_loop = true
      prev, node = [node, next_node(prev, node)]
    end
  end

  def part_1
    main_loop.length / 2
  end

  def part_2
    (0...h).sum do |y|
      juke = 0
      inside = false
      arr = (0...w).count do |x|
        n = node(x, y)
        if n.in_loop
          case n.c
          when '|'
            inside = !inside
          when 'L'
            juke = 1
          when 'F'
            juke = -1
          when '7'
            inside = !inside if juke == 1
          when 'J'
            inside = !inside if juke == -1
          end

          false
        else
          inside
        end
      end
    end
  end
end

class Node
  attr_reader :x, :y
  attr_accessor :c, :connected, :in_loop

  def initialize x, y, c
    @x = x
    @y = y
    @c = c
    @in_loop = false
  end

  def inspect
    [x, y, c]
  end

  def neighbor_direction neighbor
    nx, ny = [neighbor.x, neighbor.y]

    # Make sure neighbor is really an orthogonal neighbor
    return unless ((x - nx).abs == 1 && y == ny) || ((y - ny).abs == 1 && x == nx)

    if nx < x
      'L'
    elsif nx > x
      'R'
    elsif ny < y
      'U'
    else
      'D'
    end
  end

  def real_char_for_s
    #  n2 <- me
    #         |
    #         v
    #        n1
    #
    # if my neighbors are Down and Left (DL), I'm a 7.
    hash = { 'DL' => '7',
             'DR' => 'F',
             'DU' => '|',
             'LR' => '-',
             'LU' => 'J',
             'RU' => 'L'
    }

    neighbors = connected.map { |c| neighbor_direction(c) }.sort.join('')
    hash[neighbors]
  end
end
