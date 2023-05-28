require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library App!'
    loop do
      puts 'Please choose an option by entering a number:'
      puts '1 - List all books'
      puts '2 - List all people'
      puts '3 - Create a person'
      puts '4 - Create a book'
      puts '5 - Create a rental'
      puts '6 - List all rentals for a given person ID'
      puts '7 - Exit'

      option = gets.chomp.to_i
      case option
      when 1
        list_all_books
      when 2
        list_all_people
      when 3
        create_person
      when 4
        create_book
      when 5
        create_rental
      when 6
        list_rentals_for_person
      when 7
        exit_app
      else
        puts 'Invalid option. Please choose a valid option.'
      end
    end
  end

  private

  def list_all_books
    puts 'Books:'
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts 'People:'
    @people.each do |person|
      if person.is_a?(Student)
        puts "[Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      elsif person.is_a?(Teacher)
        puts "[Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    person_type = gets.chomp.to_i

    case person_type
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid option. Please choose a valid option.'
    end
  end

  def create_student
    puts 'Age:'
    age = gets.chomp.to_i

    puts 'Name:'
    name = gets.chomp

    puts 'Has parent permission? [Y/N]:'
    parent_permission = gets.chomp.upcase == 'Y'

    student = Student.new(age, name, parent_permission: parent_permission)
    @people << student
    puts 'Person created successfully'
  end

  def create_teacher
    puts 'Age:'
    age = gets.chomp.to_i

    puts 'Name:'
    name = gets.chomp

    puts 'Specialization:'
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts 'Person created successfully'
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

    book = @books[book_index]
    person = @people[person_index]
    rental = Rental.new(date, book, person)
    @rentals << rental
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
      rentals.each do |rental|
        puts "Date: #{rental.date}, Book '#{rental.book.title}' by '#{rental.book.author}'"
      end
    end
  end

  def exit_app
    puts 'Thank you for using this app!'
    exit
  end

  def display_books
    @books.each_with_index do |book, index|
      puts "#{index}) Title: '#{book.title}', Author: '#{book.author}'"
    end
  end