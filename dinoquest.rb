require 'gosu'
require_relative 'player'
require_relative 'friend'
require_relative 'zorder'

class DinoSmashGame < Gosu::Window

  def initialize( width=800, height=600, fullscreen=false)
    super
    self.caption = "DINOSAUR CRUSH!"

    @background_image = Gosu::Image.new(self, "media/space.png", true)

    @player = Player.new(self)
    @player.warp(400, 300)

    @friend_image = Gosu::Image.new(self, "media/punk-dino-single.png", true)
    @friends = Array.new
    @congaline = Array.new

  end

  def button_down id
    if id == Gosu::KbEscape
      close
    end
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    @player.move

    @player.collect_friends(@friends, @congaline)

    if rand(100) < 4 and @friends.size < 5 then
      @friends.push(Friend.new(@friend_image))
    end

    @congaline.each_with_index do |partydino, i|
      partydino.x = @player.x - (120 * (i + 1))
      partydino.y = @player.y - (30 * (i + 1))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @friends.each { |friend| friend.draw }
    @congaline.each do |partydino|
      @friend_image.draw(partydino.x, partydino.y, 1)
    end
  end

end

DinoSmashGame.new.show
