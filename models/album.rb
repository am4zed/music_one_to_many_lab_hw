class Album
  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(objects)
    @title = objects['title']
    @genre = objects['genre']
    @artist_id = objects['artist_id'].to_i
    @id = objects['id'].to_i if objects['id']
  end

  def save
    sql = 'INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING *'
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.list_all
    sql = 'SELECT * FROM albums'
    all_albums = SqlRunner.run(sql).map{|album| [Album.new(album).title, Album.new(album).genre]}
    return all_albums
  end

  def find_artist
    sql = 'SELECT * FROM artists WHERE id = $1'
    values = [@artist_id]
    artist_hash = SqlRunner.run(sql, values)
    return artist_hash.map { |artist| Artist.new(artist) }
  end

  def update
    sql = 'UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4'
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM albums WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM albums WHERE id = $1'
    values = [id]
    album_hash = SqlRunner.run(sql, values)
    return album_hash.map {|album| Album.new(album)}.first
  end
end
