class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(objects)
    @name = objects['name']
    @id = objects['id'].to_i if objects['id']
  end

  def save
    sql = 'INSERT INTO artists (name) VALUES ($1) RETURNING *'
    values = [@name]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.list_all
    sql = 'SELECT * FROM artists'
    all_artists = SqlRunner.run(sql).map{|artist| Artist.new(artist).name}
    return all_artists
  end

  def find_albums
    sql = 'SELECT * FROM albums WHERE artist_id = $1'
    values = [@id]
    albums_hash = SqlRunner.run(sql, values)
    return albums_hash.map { |album| [Album.new(album).title, Album.new(album).genre]  }
  end

  def update
    sql = 'UPDATE artists SET name = $1 WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM artists WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM artists WHERE id = $1'
    values = [id]
    artist_hash = SqlRunner.run(sql, values)
    return artist_hash.map {|artist| Artist.new(artist)}.first
  end
end
