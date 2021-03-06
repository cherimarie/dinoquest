class Player
  attr_accessor :x, :y

  def initialize(window)
    @dino_arr = Gosu::Image.load_tiles(window, "media/monster-lizard.png", 80, 56, true)
    @frame = 0
    @animation_counter = 0
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @roar = Gosu::Sample.new(window, "media/trex-roar.mp3")
    @loco = Gosu::Sample.new(window, "media/locomotion_short.mp3")
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 800
    @y %= 600

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    if @frame <= 9 && @animation_counter == 3
      @frame = (@frame + 1) % 10
      @animation_counter = 0
    elsif @animation_counter < 3
      @animation_counter += 1
    end
    @dino_arr[@frame].draw_rot(@x, @y, 1, (@angle - 90) )
  end

  def collect_stars(stars)
    if stars.reject! {|star| Gosu::distance(@x, @y, star.x, star.y) < 35 } then
      @score += 1
    end
  end

  def collect_friends(friends, congaline)
    friends.reject! do |friend|
      if Gosu::distance(@x, @y, friend.x + 45, friend.y + 45) < 45
        @roar.play if congaline.length < 2
        @loco.play if (congaline.length >= 2) && (congaline.length % 3 == 0)
        congaline.push friend
        true
      else
        false
      end
    end
  end

  def score
    @score
  end
end