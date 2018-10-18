require 'yaml'

class Valera
  attr_accessor :health 	#здоровье 			(0..100)
  attr_accessor :mana 		#мана(алкоголь) 	(0..100)
  attr_accessor :money 		#деньги
  attr_accessor :happiness 	#жизнерадостность 	(-10..10)
  attr_accessor :fatigue 	#усталость 			(0..100)

  def initialize (args)
    health = args[:health]
    mana = args[:mana]
    money = args[:money]
    happiness = args[:happiness]
    fatigue = args[:fatigue]
    @health = health
    @mana = mana
    @money = money
    @happiness = happiness
    @fatigue = fatigue
    @dead = 0
    
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
  
  def go_to_work #пойти на работу
    #изменения статов считанные из файла  
    @mana += @yml1['mana']
    @mana = 0 if @mana < 0  
    @money += @yml1['money']
    @happiness += @yml1['happiness']
    @happiness = -10 if @happiness < -10
    @fatigue += @yml1['fatigue']
    @fatigue = 100 if @fatigue > 100 
    
    #изменение статов вручную (не оч вариант) 
=begin 
    @mana -= 30
    @mana = 0 if @mana < 0  
    @money += 100
    @happiness -= 5
    @happiness = -10 if @happiness < -10
    @fatigue += 70
    @fatigue = 100 if @fatigue > 100
=end  
  end
  
  def see_nature #созерцать природу
    @mana += @yml2['mana']
    @mana = 0 if @mana < 0  
    @happiness += @yml2['happiness']
    @happiness = 10 if @happiness > 10
    @fatigue += @yml2['fatigue']
    @fatigue = 100 if @fatigue > 100
  end
  
  def drink_wine_and_tv_watch #пить вино и смотреть сериал
    @mana += @yml3['mana']
    @mana = 100 if @mana > 100  
    @happiness += @yml3['happiness']
    @happiness = -10 if @happiness < -10
    @fatigue += @yml3['fatigue']
    @fatigue = 100 if @fatigue > 100
    @health += @yml3['health']
    if @health < 0
      @health = 0 
      @dead = 1
    end
    @money += @yml3['money']
  end
  
  def go_to_bar #сходить в бар
    @mana += @yml4['mana']
    @mana = 100 if @mana > 100  
    @happiness += @yml4['happiness']
    @happiness = 10 if @happiness > 10
    @fatigue += @yml4['fatigue']
    @fatigue = 100 if @fatigue > 100
    @health += @yml4['health']
    if @health < 0
      @health = 0 
      @dead = 1
    end
    @money += @yml4['money']
  end
  
  def drink_with_marginals #выпить с маргинальными личностями
    @mana += @yml5['mana']
    @mana = 100 if @mana > 100  
    @happiness += @yml5['happiness']
    @happiness = 10 if @happiness > 10
    @fatigue += @yml5['fatigue']
    @fatigue = 100 if @fatigue > 100
    @health += @yml5['health']
    if @health < 0
      @health = 0 
      @dead = 1
    end
    @money += @yml5['money']
  end
  
  def sing_in_metro #петь в метро
    if (@mana > 40 && @mana < 70)
      @money += @yml6['money1']
    else
      @money += @yml6['money2']
    end
    @mana += @yml6['mana']
    @mana = 100 if @mana > 100  
    @happiness += @yml6['happiness']
    @happiness = 10 if @happiness > 10
    @fatigue += @yml6['fatigue']
    @fatigue = 100 if @fatigue > 100
  end
  
  def sleep #спать
    @health += @yml7['health'] if @mana < 30
    @health = 100 if @health > 100
    @mana += @yml7['mana']
    @mana = 0 if @mana < 0  
    @happiness += @yml7['happiness'] if @mana > 70
    @happiness = -10 if @happiness < -10
    @fatigue += @yml7['fatigue']
    @fatigue = 0 if @fatigue < 0
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


#######################Точка входа#######################   
stat = Stats.new
yml = stat.load("stat.yml")
#начальные статы Валеры загружаем из файла
valera = Valera.new({:health => yml['health'], :mana => yml['mana'], :money => yml['money'], :happiness => yml['happiness'], :fatigue => yml['fatigue']})

view = View.new
view.welcome
  
while valera.dead? != 1
  #сохранение статов Валеры в файл после каждого действия
  stat.save('save.yml', valera)

  valera.stat
  view.actions
  print "> "
  action = gets.chomp
    
  case action
    when "1"
	  if (valera.mana > 50 && valera.fatigue > 10)
	    puts "Валера очень устал, чтобы идти на работу. К тому же он пьян...\n"
      else
	    puts "Валера нехотя побрел на работу, матеря про себя игрока.\n"
	    valera.go_to_work
	    puts "Еле волоча своё бренное тело, Валера вернулся с работы.\n"
	  end
    when "2"
      puts "Валера вышел на балкон и стал любоваться природой... Алкоголь потихоньку выветривался, настроение росло.\n"
      valera.see_nature
      puts "Подышав воздухом (\"Хотя бы за это не надо платить!\" - подумал про себя Валера), он вернулся в квартиру.\n"
    when "3"
      if valera.money < 20
        puts "\"Дожился... Нет грёбаных 20$ на бутылочку вина!\" - подумал Валера. Расслабиться не получится :(\n"
      else
        puts "Купив бутылочку дешманского вина (благо рядом Пятёрочка!), Валера хорошо провел время, смотря сериал Бандитский Петербург.\n"
        valera.drink_wine_and_tv_watch
        puts "Сериал закончился. Да и фунфырёк уже пуст. Чем же заняться далее?\n"
      end
    when "4"
      if valera.money < 100
        puts "\"Какой бар?! У меня даже 100$ нет для этого!\" - разозлился Валера на игрока.\n"
      else
        puts "Одев свой лучший пиджак с выпускного (\"вдруг девочку какую встречу?\"), Валера направился знакомой до боли дорожкой в бар.\n"
        valera.go_to_bar
        puts "Девочку Валера не встретил :( Зато нажрался как свинья. Да и карманы стали легче, что еще больше огорчило Валеру.\n"
      end
    when "5"
      if valera.money < 150
        puts "У Валеры нет столько денег, чтобы угостить бухлом своим друзей-маргиналов!\n"
      else
        puts "Накрыв поляну на крышке погреба Петровича (это было местом сходки всех местных маргиналов), Валера проставился бухлом перед пацанами.\n"
        valera.drink_with_marginals
        puts "Обблёванный и грязный Валера вернулся домой ближе к утру. Денег в карманах изрядно поубавилось.\n"
      end
    when "6"
      if (valera.mana > 40 && valera.mana < 70)
        puts "Когда Валера был изрядно пьян, петь у него получалось лучше. Душевнее. Неравнодушные и растроганные песней прохожие подкидывали больше деньжат!\n"
      else
        puts "То ли Валера был недостаточно пьян, чтобы хорошо спеть, то ли прохожим не зашла песня Владимирский Централ. Много денег срубить не удалось :(\n"
      end  
      valera.sing_in_metro
      puts "Проведя творческий вечер в метро (и выступив несколько раз на бис), Валера пришкондыбал домой уставшим.\n"
    when "7"
      if (valera.mana < 30)
        puts "Будучи практически трезвым, Валере удалось неплохо выспаться!\n"
      else
        puts "Пьяный в дрова Валера завалился на кровать, не сняв даже обувь. Сон почти не принес облегчения. Наутро похмелье сказало Валере \"здравствуй!\"\n"
      end  
      valera.sleep
      puts "Отойдя ото сна, Валера почесал репу, размышляя чем бы себя занять.\n"
    else
      puts "Хватит проверок на дурака! Выбери действия из предложенных!\n"
  end
end
  
view.dead
