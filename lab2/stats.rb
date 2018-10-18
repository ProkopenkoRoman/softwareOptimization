require 'yaml'

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
