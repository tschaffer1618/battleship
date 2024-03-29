class Ship
  attr_reader :name, :length
  attr_accessor :health
  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk?
    @health >= 1 ? false : true
  end

  def hit
    @health -= 1 unless @health == 0
  end
end
