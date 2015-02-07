class Friend
  attr_reader :x, :y

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color.new(0xff000000)
    @x = rand * 800
    @y = rand * 600
  end

  def draw
    @animation.draw(@x, @y, 1)
  end
end