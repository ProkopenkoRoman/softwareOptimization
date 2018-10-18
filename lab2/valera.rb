require 'yaml'

class Valera
  attr_accessor :health 	#здоровье 				(0..100)
  attr_accessor :mana 		#мана(алкоголь) 			(0..100)
  attr_accessor :money 		#деньги
  attr_accessor :happiness 	#жизнерадостность 			(-10..10)
  attr_accessor :fatigue 	#усталость 				(0..100)
  attr_accessor :dead 		#мертв?

  def initialize (args)
    @health = args[:health]
    @mana = args[:mana]
    @money = args[:money]
    @happiness = args[:happiness]
    @fatigue = args[:fatigue]
    @dead = args[:dead]
  end
  
  def dead? #жив ли Валера?
    return @dead
  end
end
