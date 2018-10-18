require_relative 'valera.rb'
require_relative 'stats.rb'
require_relative 'actions.rb'
require_relative 'view.rb'

stat = Stats.new
yml = stat.load("stat.yml")
#начальные статы Валеры загружаем из файла + то, что он жив (dead = 0)
valera = Valera.new({:health => yml['health'], :mana => yml['mana'], :money => yml['money'], :happiness => yml['happiness'], :fatigue => yml['fatigue'], :dead => 0})

view = View.new
view.welcome
  
while valera.dead? != 1
  view.stat(valera)
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
	    action.go_to_work(valera)
	    puts "Еле волоча своё бренное тело, Валера вернулся с работы.\n"
	  end
    when "2"
      puts "Валера вышел на балкон и стал любоваться природой... Алкоголь потихоньку выветривался, настроение росло.\n"
      action.see_nature(valera)
      puts "Подышав воздухом (\"Хотя бы за это не надо платить!\" - подумал про себя Валера), он вернулся в квартиру.\n"
    when "3"
      if valera.money < 20
        puts "\"Дожился... Нет грёбаных 20$ на бутылочку вина!\" - подумал Валера. Расслабиться не получится :(\n"
      else
        puts "Купив бутылочку дешманского вина (благо рядом Пятёрочка!), Валера хорошо провел время, смотря сериал Бандитский Петербург.\n"
        action.drink_wine_and_tv_watch(valera)
        puts "Сериал закончился. Да и фунфырёк уже пуст. Чем же заняться далее?\n"
      end
    when "4"
      if valera.money < 100
        puts "\"Какой бар?! У меня даже 100$ нет для этого!\" - разозлился Валера на игрока.\n"
      else
        puts "Одев свой лучший пиджак с выпускного (\"вдруг девочку какую встречу?\"), Валера направился знакомой до боли дорожкой в бар.\n"
        action.go_to_bar(valera)
        puts "Девочку Валера не встретил :( Зато нажрался как свинья. Да и карманы стали легче, что еще больше огорчило Валеру.\n"
      end
    when "5"
      if valera.money < 150
        puts "У Валеры нет столько денег, чтобы угостить бухлом своих друзей-маргиналов!\n"
      else
        puts "Накрыв поляну на крышке погреба Петровича (это было местом сходки всех местных маргиналов), Валера проставился бухлом перед пацанами.\n"
        action.drink_with_marginals(valera)
        puts "Обблёванный и грязный Валера вернулся домой ближе к утру. Денег в карманах изрядно поубавилось.\n"
      end
    when "6"
      if (valera.mana > 40 && valera.mana < 70)
        puts "Когда Валера был изрядно пьян, петь у него получалось лучше. Душевнее. Неравнодушные и растроганные песней прохожие подкидывали больше деньжат!\n"
      else
        puts "То ли Валера был недостаточно пьян, чтобы хорошо спеть, то ли прохожим не зашла песня Владимирский Централ. Много денег срубить не удалось :(\n"
      end 
      action.sing_in_metro(valera) 
      puts "Проведя творческий вечер в метро (и выступив несколько раз на бис), Валера пришкондыбал домой уставшим.\n"
    when "7"
      if (valera.mana < 30)
        puts "Будучи практически трезвым, Валере удалось неплохо выспаться!\n"
      else
        puts "Пьяный в дрова Валера завалился на кровать, не сняв даже обувь. Сон почти не принес облегчения. Наутро похмелье сказало Валере \"здравствуй!\"\n"
      end  
      action.sleep(valera)
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
view.stat(valera)
