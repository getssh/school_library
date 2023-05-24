class Person
  attr_accessor :name, :age
  attr_reader :id

  def initializename(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..10_000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end

  def can_use_services?
    of_age? || @parent_permission
  end
end
