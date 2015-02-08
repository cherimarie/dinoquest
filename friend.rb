class Friend
  attr_accessor :x, :y

  def initialize(friend_pic)
    @friend_pic = friend_pic
    @x = rand * 800
    @y = rand * 600
  end

  def draw
    @friend_pic.draw(@x, @y, 1)
  end

end