require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

class App
  MENU_OPTIONS = {
    1 => :list_all_books,
    2 => :list_all_people,
    3 => :create_person,
    4 => :create_book,
    5 => :create_rental,
    6 => :list_rentals_for_person,
    7 => :exit_app
  }.freeze

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library App!'
    loop do
      display_menu
      handle_option(gets.chomp.to_i)
    end
  end

  private

  def handle_option(option)
    if MENU_OPTIONS.key?(option)
      send(MENU_OPTIONS[option])
    else
      puts 'Invalid option. Please choose a valid option.'
    end
  end

  def display_menu
    puts <<~MENU
      Please choose an option by entering a number:
      1 - List all books
      2 - List all people
      3 - Create a person
      4 - Create a book
      5 - Create a rental
      6 - List all rentals for a given person ID
      7 - Exit
    MENU
  end

  def list_all_books
    puts 'Books:'
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list_all_people
    puts 'People:'
    @people.each { |person| puts person_info(person) }
  end

  def display_people
    @people.each_with_index { |person, index| puts "#{index}) #{person_info(person)}" }
  end

  def person_info(person)
    case person
    when Student
      "[Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    when Teacher
      "[Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    case gets.chomp.to_i
    when 1 then create_student
    when 2 then create_teacher
    else puts 'Invalid option. Please choose a valid option.'
    end
  end

  def create_student
    puts 'Age:'
    age = gets.chomp.to_i
    puts 'Name:'
    name = gets.chomp
    puts 'Has parent permission? [Y/N]:'
    parent_permission = gets.chomp.upcase == 'Y'
    @people << Student.new(age, name, parent_permission: parent_permission)
    puts 'Person created successfully'
  end

  def create_teacher
    puts 'Age:'
    age = gets.chomp.to_i
    puts 'Name:'
    name = gets.chomp
    puts 'Specialization:'
    specialization = gets.chomp
    @people << Teacher.new(age, specialization, name)
    puts 'Person created successfully'
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    display_books
    book_index = gets.chomp.to_i
    return puts 'Invalid book selection.' unless valid_book_index?(book_index)

    puts 'Select a person from the following list by number:'
    display_people
    person_index = gets.chomp.to_i
    return puts 'Invalid person selection.' unless valid_person_index?(person_index)

    puts 'Date:'
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
  end

  def list_rentals_for_person
    puts 'ID of person:'
    person_id = gets.chomp.to_i
    rentals = @rentals.select { |rental| rental.person.id == person_id }
    if rentals.empty?
      puts 'No rentals found for the given person ID.'
    else
      puts 'Rentals:'
      rentals.each { |rental| puts "Date: #{rental.date}, Book '#{rental.book.title}' by '#{rental.book.author}'" }
    end
  end

  def exit_app
    puts 'Thank you for using this app!'
    exit
  end

  def display_books
    @books.each_with_index { |book, index| puts "#{index}) Title: '#{book.title}', Author: '#{book.author}'" }
  end

  def valid_book_index?(index)
    index.between?(0, @books.length - 1)
  end

  def valid_person_index?(index)
    index.between?(0, @people.length - 1)
  end
end
