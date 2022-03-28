module Countable
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods

    # переменную уровня класса со счетчиком нужно проинициализировать
    base.instances = 0 
  end 

  module ClassMethods
    attr_accessor :instances

    # Чтобы в потомках тоже проинициализировать
    def inherited(subclass)
      subclass.instances = 0
    end
  end

  module InstanceMethods 
    protected 

    def register_instance
       # Хотим, чтобы счетчик в родительском классе тоже инкрементировался 
       #  например: Train.instances будет показывать все поезда, а CargoTrain.instances только грузовые 
       self.class.instances += 1 
       self.class.superclass.instances += 1 if self.class.superclass.instance_variable_defined?(:@instances)
    end
  end
end