class Actions #класс управления действиями Валеры
  def initialize
    #создание файлов с конфигурацией каждого действия
    @stat = Stats.new #объект для работы с YAML
    @yml = @stat.load("actions.yml")
  end
  
  def go_to_work(valera) #пойти на работу
    #изменения статов считанные из файла  
    valera.mana += @yml['go_to_work']['mana']
    valera.mana = 0 if valera.mana < 0  
    valera.money += @yml['go_to_work']['money']
    valera.happiness += @yml['go_to_work']['happiness']
    valera.happiness = -10 if valera.happiness < -10
    valera.fatigue += @yml['go_to_work']['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100 
  end
  
  def see_nature(valera) #созерцать природу
    valera.mana += @yml['see_nature']['mana']
    valera.mana = 0 if valera.mana < 0  
    valera.happiness += @yml['see_nature']['happiness']
    valera.happiness = 10 if valera.happiness > 10
    valera.fatigue += @yml['see_nature']['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
  end
  
  def drink_wine_and_tv_watch(valera) #пить вино и смотреть сериал
    valera.mana += @yml['drink_wine_and_tv_watch']['mana']
    valera.mana = 100 if valera.mana > 100  
    valera.happiness += @yml['drink_wine_and_tv_watch']['happiness']
    valera.happiness = -10 if valera.happiness < -10
    valera.fatigue += @yml['drink_wine_and_tv_watch']['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
    valera.health += @yml['drink_wine_and_tv_watch']['health']
    if valera.health <= 0
      valera.health = 0 
      valera.dead = 1
    end
    valera.money += @yml['drink_wine_and_tv_watch']['money']
  end
  
  def go_to_bar(valera) #сходить в бар
    valera.mana += @yml['go_to_bar']['mana']
    valera.mana = 100 if valera.mana > 100  
    valera.happiness += @yml['go_to_bar']['happiness']
    valera.happiness = 10 if valera.happiness > 10
    valera.fatigue += @yml['go_to_bar']['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
    valera.health += @yml['go_to_bar']['health']
    if valera.health <= 0
      valera.health = 0 
      valera.dead = 1
    end
    valera.money += @yml['go_to_bar']['money']
  end
  
  def drink_with_marginals(valera) #выпить с маргинальными личностями
    valera.mana += @yml['drink_with_marginals']['mana']
    valera.mana = 100 if valera.mana > 100  
    valera.happiness += @yml['drink_with_marginals']['happiness']
    valera.happiness = 10 if valera.happiness > 10
    valera.fatigue += @yml['drink_with_marginals']['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
    valera.health += @yml['drink_with_marginals']['health']
    if valera.health <= 0
      valera.health = 0 
      valera.dead = 1
    end
    valera.money += @yml['drink_with_marginals']['money']
  end
  
  def sing_in_metro(valera) #петь в метро
    if (valera.mana > 40 && valera.mana < 70)
      valera.money += @yml['sing_in_metro']['money1']
    else
      valera.money += @yml['sing_in_metro']['money2']
    end
    valera.mana += @yml['sing_in_metro']['mana']
    valera.mana = 100 if valera.mana > 100  
    valera.happiness += @yml['sing_in_metro']['happiness']
    valera.happiness = 10 if valera.happiness > 10
    valera.fatigue += @yml['sing_in_metro']['fatigue']
    valera.fatigue = 100 if valera.fatigue > 100
  end
  
  def sleep(valera) #спать
    valera.health += @yml['sleep']['health'] if valera.mana < 30
    valera.health = 100 if valera.health > 100
    valera.mana += @yml['sleep']['mana']
    valera.mana = 0 if valera.mana < 0  
    valera.happiness += @yml['sleep']['happiness'] if valera.mana > 70
    valera.happiness = -10 if valera.happiness < -10
    valera.fatigue += @yml['sleep']['fatigue']
    valera.fatigue = 0 if valera.fatigue < 0
  end  
end
