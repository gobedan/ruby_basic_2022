# frozen_string_literal: true

module Countable
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods

    # class-level variable should be initialized
    base.instances = 0
  end

  module ClassMethods
    attr_accessor :instances

    # in child classes it should be initialized too
    def inherited(subclass)
      super
      subclass.instances = 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      # Counter in superclass should increment too
      #   ex.: Train.instances shows all trains, CargoTrain.instances shows only cargo trains count
      self.class.instances += 1
      return unless self.class.superclass.instance_variable_defined?(:@instances)

      self.class.superclass.instances += 1
    end
  end
end
