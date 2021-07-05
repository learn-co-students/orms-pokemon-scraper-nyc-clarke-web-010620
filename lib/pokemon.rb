require 'pry'
class Pokemon
    attr_reader :id, :db
    attr_accessor :name, :type
    def initialize(name, type = "", id = nil, db = db)
        @name = name
        @type = type
        @id = id
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) 
            VALUES (?, ?)
        SQL
     
        db.execute(sql, name, type)
     
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?
    SQL
        row = db.execute(sql, id)
        #binding.pry
        name = row[0][1]
        type = row[0][2]
        new_pokemon = self.new(name, type, id, db)
        new_pokemon
    end

end
