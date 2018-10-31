require_relative 'valera.rb'
require_relative 'stats.rb'
require_relative 'actions.rb'
require_relative 'view.rb'

class Test #класс тестов
  def started_stats_test(valera) #метод проверки валидности начальных параметров Валеры
    if(valera.health == 100)
      puts "successfull value of health"
    else
      puts "invalid value of health"
    end
      
    if(valera.mana == 0)
      puts "successfull value of mana"
    else
      puts "invalid value of mana"
    end
      
    if(valera.money == 100)
      puts "successfull value of money"
    else
      puts "invalid value of money"
    end
      
    if(valera.happiness == 10)
      puts "successfull value of happiness"
    else
      puts "invalid value of happiness"
    end
      
    if(valera.fatigue == 0)
      puts "successfull value of fatigue\n\n"
    else
      puts "invalid value of fatigue\n\n"
    end
  end
   
  def action_go_to_work_test(valera) #тест на метод go_to_work
    action = Actions.new
    action.go_to_work(valera)
    if(valera.mana == 0 && valera.money == 200 && valera.happiness == 5 && valera.fatigue == 70)
      puts "Action go_to_work are successfull\n\n"
    else
      puts "Action go_to_work are invalid\n\n"
    end
  end
   
  def action_go_to_bar_test(valera) #тест на метод go_to_bar
    action = Actions.new
    action.go_to_bar(valera)
    if(valera.mana == 60 && valera.money == 0 && valera.happiness == 10 && valera.fatigue == 40 && valera.health == 90)
      puts "Action go_to_bar are successfull\n\n"
    else
      puts "Action go_to_bars are invalid\n\n"
    end
  end
   
  def load_test(valera1) #тест на правильность загрузки сохраненных статов
    action = Actions.new
    action.go_to_work(valera1) #сводим valera1 на работу
    s = Stats.new
    s.save("test_save.yml", valera1) #сохраним статы valera1
      
    yml = s.load("test_save.yml") #загрузим в valera2 статы из сохраненного файла
    #создаем valera2
    valera2 = Valera.new({:health => yml['health'], :mana => yml['mana'], :money => yml['money'], :happiness => yml['happiness'], :fatigue => yml['fatigue'], :dead => 0})
      
    #убедимся, что загрузка прошла удачно
    if(valera1.health == valera2.health && valera1.mana == valera2.mana && valera1.money == valera2.money && valera1.happiness == valera2.happiness && valera1.fatigue == valera2.fatigue)
      puts "test load successfull\n"
    else
      puts "test load invalid\n"
    end
  end
   
end

stat = Stats.new
yml = stat.load("stat.yml")
#начальные статы Валеры загружаем из файла + то, что он жив (dead = 0)
valera = Valera.new({:health => yml['health'], :mana => yml['mana'], :money => yml['money'], :happiness => yml['happiness'], :fatigue => yml['fatigue'], :dead => 0})

#тест на проверку стартовых статов Валеры
t = Test.new
t.started_stats_test(valera)

#тест на действие "пойти на работу"
t.action_go_to_work_test(valera)
valera = nil

#тест на действие "пойти в бар"
valera = Valera.new({:health => yml['health'], :mana => yml['mana'], :money => yml['money'], :happiness => yml['happiness'], :fatigue => yml['fatigue'], :dead => 0})
t.action_go_to_bar_test(valera)
valera = nil

#тест на загрузку статов из сохраненного файла
valera1 = Valera.new({:health => yml['health'], :mana => yml['mana'], :money => yml['money'], :happiness => yml['happiness'], :fatigue => yml['fatigue'], :dead => 0})
t.load_test(valera1)
valera = nil
