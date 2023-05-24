class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initializename(name = 'Unknown', age, parent_permission: true)
    super()
    @id = Random.rand(1..10000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end
