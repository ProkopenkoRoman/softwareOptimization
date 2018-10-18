require 'yaml'

class Valera
  attr_accessor :health 	#здоровье 			(0..100)
  attr_accessor :mana 		#мана(алкоголь) 		(0..100)
  attr_accessor :money 		#деньги
  attr_accessor :happiness 	#жизнерадостность 		(-10..10)
  attr_accessor :fatigue 	#усталость 			(0..100)
  attr_accessor :dead 		#мертв?

  def initialize (args)
    health = args[:health]
    mana = args[:mana]
    money = args[:money]
    happiness = args[:happiness]
    fatigue = args[:fatigue]
    dead = args[:dead]
    @health = health
    @mana = mana
    @money = money
    @happiness = happiness
    @fatigue = fatigue
    @dead = dead
    
    #создание файлов с конфигурацией каждого действия
    @stat = Stats.new #объект для работы с YAML
    @yml1 = @stat.load("go_to_work.yml")
    @yml2 = @stat.load("see_nature.yml")
    @yml3 = @stat.load("drink_wine_and_tv_watch.yml")
    @yml4 = @stat.load("go_to_bar.yml")
    @yml5 = @stat.load("drink_with_marginals.yml")
    @yml6 = @stat.load("sing_in_metro.yml")
    @yml7 = @stat.load("sleep.yml")
  end
   
  def stat #статы Валеры
    puts "Параметры Валеры:\n"
    puts "Здоровье = #{health}\n"
    puts "Мана = #{mana}\n"
    puts "Деньги = #{money}\n"
    puts "Жизнерадостность = #{happiness}\n"
    puts "Усталость = #{fatigue}\n"
    puts "\n"
  end
  
  def dead? #жив ли Валера?
    return @dead
  end
end


class View
  def welcome
    puts "Ништяк Валера! Настало твоё время!\n"
  end
  
  def actions
    puts "Выберите действие:"
    puts "1) Пойти на работу\n"
    puts "2) Созерцать природу\n"
    puts "3) Пить вино и смотреть сериал\n"
    puts "4) Сходить в бар\n"
    puts "5) Выпить с маргинальными личностями\n"
    puts "6) Петь в метро\n"
    puts "7) Спать\n"
    puts "8) Сохранить\n"
    puts "9) Загрузить\n"
  end
  
  def dead
    puts "На этом заканчивается судьба маргинала Валеры... Мораль: помните, что печень не вечная.\n"
  end
end


class Stats #класс для работы с файлами YAML
  def load(filename) #загрузка из файла статов Валеры
    YAML::load(File.open(filename))
  end
  
  def save(filename, valera) #сохранение текущих статов Валеры
    File.open(filename, 'w') { |file| 
      file.puts("health: #{valera.health}") 
      file.puts("mana: #{valera.mana}") 
      file.puts("money: #{valera.money}") 
      file.puts("happiness: #{valera.happiness}") 
      file.puts("fatigue: #{valera.fatigue}") 
    }
  end
end


class Actions #класс управления действиями Валеры
  def initialize
    #создание файлов с конфигурацией каждого действия
    @stat = Stats.new #объект для работы с YAML
    @yml1 = @stat.load("go_to_work.yml")
    @yml2 = @stat.load("see_nature.yml")
    @yml3 = @stat.load("drink_wine_and_tv_watch.yml")
    @yml4 = @stat.load("go_to_bar.yml")
    @yml5 = @stat.load("drink_with_marginals.yml")
    @yml6 = @stat.load("sing_in_metro.yml")
    @yml7 = @stat.load("sleep.yml")
  end
  
  def go_to_work(valera) #пойти на работу
    #изменения статов считанные из файла  
    valera.mana += @yml1['mana']
    valera.mana = 0 if valera.mana < 0  
    valera.money += @yml1['money']
    valera.happiness += @yml1['happiness']
    valera.happiness = -10 if valera.happiness < -10
    valera.fatigue += @yml1['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100 
    
    #изменение статов вручную (не оч вариант) 
=begin 
    valera.mana -= 30
    valera.mana = 0 if valera.mana < 0  
    valera.money += 100
    valera.happiness -= 5
    valera.happiness = -10 if valera.happiness < -10
    valera.fatigue += 70
   valera.fatigue = 100 if valera.fatigue > 100
=end  
  end
  
  def see_nature(valera) #созерцать природу
    valera.mana += @yml2['mana']
    valera.mana = 0 if valera.mana < 0  
    valera.happiness += @yml2['happiness']
    valera.happiness = 10 if valera.happiness > 10
    valera.fatigue += @yml2['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
  end
  
  def drink_wine_and_tv_watch(valera) #пить вино и смотреть сериал
    valera.mana += @yml3['mana']
    valera.mana = 100 if valera.mana > 100  
    valera.happiness += @yml3['happiness']
    valera.happiness = -10 if valera.happiness < -10
    valera.fatigue += @yml3['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
    valera.health += @yml3['health']
    if valera.health <= 0
      valera.health = 0 
      valera.dead = 1
    end
    valera.money += @yml3['money']
  end
  
  def go_to_bar(valera) #сходить в бар
    valera.mana += @yml4['mana']
    valera.mana = 100 if valera.mana > 100  
    valera.happiness += @yml4['happiness']
    valera.happiness = 10 if valera.happiness > 10
    valera.fatigue += @yml4['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
    valera.health += @yml4['health']
    if valera.health <= 0
      valera.health = 0 
      valera.dead = 1
    end
    valera.money += @yml4['money']
  end
  
  def drink_with_marginals(valera) #выпить с маргинальными личностями
    valera.mana += @yml5['mana']
    valera.mana = 100 if valera.mana > 100  
    valera.happiness += @yml5['happiness']
    valera.happiness = 10 if valera.happiness > 10
    valera.fatigue += @yml5['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
    valera.health += @yml5['health']
    if valera.health <= 0
      valera.health = 0 
      valera.dead = 1
    end
    valera.money += @yml5['money']
  end
  
  def sing_in_metro(valera) #петь в метро
    if (valera.mana > 40 && valera.mana < 70)
      valera.money += @yml6['money1']
    else
      valera.money += @yml6['money2']
    end
    valera.mana += @yml6['mana']
    valera.mana = 100 if valera.mana > 100  
    valera.happiness += @yml6['happiness']
    valera.happiness = 10 if valera.happiness > 10
    valera.fatigue += @yml6['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
  end
  
  def sleep(valera) #спать
    valera.health += @yml7['health'] if valera.mana < 30
    valera.health = 100 if valera.health > 100
    valera.mana += @yml7['mana']
    valera.mana = 0 if valera.mana < 0  
    valera.happiness += @yml7['happiness'] if valera.mana > 70
    valera.happiness = -10 if valera.happiness < -10
    valera.fatigue += @yml7['fatigue']
    valera.fatigue = 0 if valera.fatigue < 0
  end  
end

#######################Точка входа#######################   
stat = Stats.new
yml = stat.load("stat.yml")
#начальные статы Валеры загружаем из файла + то, что он жив (dead = 0)
valera = Valera.new({:health => yml['health'], :mana => yml['mana'], :money => yml['money'], :happiness => yml['happiness'], :fatigue => yml['fatigue'], :dead => 0})

view = View.new
view.welcome
  
while valera.dead? != 1
  valera.stat
  view.actions
  print "> "
  action_choise = gets.chomp
  
  action = Actions.new  
  case action_choise
    when "1"
	  if (valera.mana > 50 && valera.fatigue > 10)
	    puts "Валера очень устал, чтобы идти на работу. К тому же он пьян...\n"
      else
	    puts "Валера нехотя побрел на работу, матеря про себя игрока.\n"
	    #valera.go_to_work
	    action.go_to_work(valera)
	    puts "Еле волоча своё бренное тело, Валера вернулся с работы.\n"
	  end
    when "2"
      puts "Валера вышел на балкон и стал любоваться природой... Алкоголь потихоньку выветривался, настроение росло.\n"
      action.see_nature(valera)
      #valera.see_nature
      puts "Подышав воздухом (\"Хотя бы за это не надо платить!\" - подумал про себя Валера), он вернулся в квартиру.\n"
    when "3"
      if valera.money < 20
        puts "\"Дожился... Нет грёбаных 20$ на бутылочку вина!\" - подумал Валера. Расслабиться не получится :(\n"
      else
        puts "Купив бутылочку дешманского вина (благо рядом Пятёрочка!), Валера хорошо провел время, смотря сериал Бандитский Петербург.\n"
        action.drink_wine_and_tv_watch(valera)
        #valera.drink_wine_and_tv_watch
        puts "Сериал закончился. Да и фунфырёк уже пуст. Чем же заняться далее?\n"
      end
    when "4"
      if valera.money < 100
        puts "\"Какой бар?! У меня даже 100$ нет для этого!\" - разозлился Валера на игрока.\n"
      else
        puts "Одев свой лучший пиджак с выпускного (\"вдруг девочку какую встречу?\"), Валера направился знакомой до боли дорожкой в бар.\n"
        action.go_to_bar(valera)
        #valera.go_to_bar
        puts "Девочку Валера не встретил :( Зато нажрался как свинья. Да и карманы стали легче, что еще больше огорчило Валеру.\n"
      end
    when "5"
      if valera.money < 150
        puts "У Валеры нет столько денег, чтобы угостить бухлом своих друзей-маргиналов!\n"
      else
        puts "Накрыв поляну на крышке погреба Петровича (это было местом сходки всех местных маргиналов), Валера проставился бухлом перед пацанами.\n"
        action.drink_with_marginals(valera)
        #valera.drink_with_marginals
        puts "Обблёванный и грязный Валера вернулся домой ближе к утру. Денег в карманах изрядно поубавилось.\n"
      end
    when "6"
      if (valera.mana > 40 && valera.mana < 70)
        puts "Когда Валера был изрядно пьян, петь у него получалось лучше. Душевнее. Неравнодушные и растроганные песней прохожие подкидывали больше деньжат!\n"
      else
        puts "То ли Валера был недостаточно пьян, чтобы хорошо спеть, то ли прохожим не зашла песня Владимирский Централ. Много денег срубить не удалось :(\n"
      end 
      action.sing_in_metro(valera) 
      #valera.sing_in_metro
      puts "Проведя творческий вечер в метро (и выступив несколько раз на бис), Валера пришкондыбал домой уставшим.\n"
    when "7"
      if (valera.mana < 30)
        puts "Будучи практически трезвым, Валере удалось неплохо выспаться!\n"
      else
        puts "Пьяный в дрова Валера завалился на кровать, не сняв даже обувь. Сон почти не принес облегчения. Наутро похмелье сказало Валере \"здравствуй!\"\n"
      end  
      action.sleep(valera)
      #valera.sleep
      puts "Отойдя ото сна, Валера почесал репу, размышляя чем бы себя занять.\n"
    when "8"
      puts "Валера сделал сохранение.\n"
      stat.save('save.yml', valera)
    when "9"
      stat = Stats.new
      yml = stat.load("save.yml")
      #начальные статы Валеры загружаем из файла сохранения + то, что он жив (dead = 0)
      valera = Valera.new({:health => yml['health'], :mana => yml['mana'], :money => yml['money'], :happiness => yml['happiness'], :fatigue => yml['fatigue'], :dead => 0})
    else
      puts "Хватит проверок на дурака! Выбери действия из предложенных!\n"
  end
end
  
view.dead
