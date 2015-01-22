class TrafficLight  
  include Enumerable

  def each
    yield [true, false, false]
    yield [true, true, false]
    yield [false, false, true]
    yield [false, true, false]
  end
end

class Bulb < Shoes::Shape
  attr_accessor :stack
  attr_accessor :left
  attr_accessor :top
  attr_accessor :switched_on
  
  def initialize(stack, left, top, switched_on = false)    
    self.stack = stack
    self.left = left    
    self.top = top
    self.switched_on = switched_on
    draw left, top, bulb_colour
  end
  
  # HINT: Shouldn't need to change this method
  def draw(left, top, colour)    
    stack.fill(colour)
    stack.oval(left, top, 50)
  end

  def bulb_colour
    "#999999"
  end  
end


module TL
  Go = "#00FF30"
  Wait = "#FFFC00"
  Stop = "#FF0000"
end

  class StopBulb < Bulb
    def bulb_colour
      if switched_on
      TL::Stop
      else
      "#999999"
      end
    end
  end

  class WaitBulb < Bulb
    def bulb_colour
      if switched_on
      TL::Wait
      else
      "#999999"
      end
    end
  end

   class GoBulb < Bulb
    def bulb_colour
      if switched_on
      TL::Go
      else
      "#999999"
      end
    end
  end

Shoes.app :title => "My Amazing Traffic Light", :width => 150, :height => 250 do
  background "#000000".."#666666", :curve => 10, :margin => 25  
  stroke black    
  
  @traffic_light = TrafficLight.new
  @top = StopBulb.new self, 50, 40, true
  @middle = WaitBulb.new self, 50, 100, false
  @bottom = GoBulb.new self, 50, 160, false
  
  #animate(1) do
  i = 0
  click do 
    animate(4) do
      if i <= 3
        state = @traffic_light.to_a[i] 
          @top = StopBulb.new self, 50, 40, state[0]     
          @middle = WaitBulb.new self, 50, 100, state[1]
          @bottom = GoBulb.new self, 50, 160, state[2]
          i+=1
      else
        i=0
      end
    end
  #end
      
    #How can we change i?
    #   @traffic_light.next
  end
end

