require_relative 'nameable.rb'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..10_000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end

class PersonDecorator < Nameable
  def initialize(nameable)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < PersonDecorator
  def correct_name
    capName = @nameable.correct_name
    capName.capitalize
  end
end

class TrimmerDecorator < PersonDecorator
  def correct_name
    str = @nameable.correct_name
    str.slice(0, 10)
  end
end
