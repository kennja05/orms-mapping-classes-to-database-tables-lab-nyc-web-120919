require 'pry'

class Student

    attr_reader :id, :name, :grade
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
    def initialize(name, grade)
      @name = name
      @grade = grade 
    end
    
    def self.create_table 
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade TEXT
        )
        SQL
        DB[:conn].execute(sql)
    end 

    def self.drop_table
      sql = <<-SQL
      DROP TABLE students
      SQL
      DB[:conn].execute(sql)
    end 

    def save
      sql = <<-SQL
        INSERT INTO students (name, grade)
        VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end 

    def self.create(attr_hash)
      my_student = Student.new(attr_hash[:name], attr_hash[:grade])
      #binding.pry 

      my_student.save
      my_student
    end 



end
