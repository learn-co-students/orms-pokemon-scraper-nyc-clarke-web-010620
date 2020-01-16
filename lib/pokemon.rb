class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id: id, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end


    def self.save(name, type, db)
        pokemon = Pokemon.new(name: name, type: type, db: db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL
        db.execute(sql, pokemon.name, pokemon.type)
        pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
        SQL
        array = db.execute(sql, id).flatten
        Pokemon.new(id: array[0], name: array[1], type: array[2], db: db)
    end

end
