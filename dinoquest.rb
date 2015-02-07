require 'gosu'
require_relative 'player'
require_relative 'black_hole'
require_relative 'zorder'

class DinoSmashGame < Gosu::Window

  def initialize( width=800, height=600, fullscreen=false)
    super
    self.caption = "DINOSAUR CRUSH!"

    @background_image = Gosu::Image.new(self, "media/space.png", true)

    @player = Player.new(self)
    @player.warp(320, 240)

    @star_anim = Gosu::Image::load_tiles(self, "media/star.png", 25, 25, false)
    @stars = Array.new

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
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Star.new(@star_anim))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @stars.each { |star| star.draw }
  end

end

DinoSmashGame.new.show
