require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')

artist1 = Artist.new('name' => 'Beyonce')
artist1.save
artist2 = Artist.new('name' => 'Jay Z')
artist2.save
artist3 = Artist.new('name' => 'Arcade Fire')
artist3.save
artist4 = Artist.new('name' => 'Foo Fighters')
artist4.save

album1 = Album.new('title' => 'Blueprint', 'genre' => 'Hip Hop', 'artist_id' => artist2.id)
album1.save
album2 = Album.new('title' => 'Funeral', 'genre' => 'Indie', 'artist_id' => artist2.id)
album2.save

artist1.name = "Queen B"
artist1.update

album2.artist_id = artist3.id
album2.update

# artist2.delete

# album1.delete

p Album.find_by_id(2)
p Artist.find_by_id(1)
# p Artist.list_all
#
# p Album.list_all

# p artist2.find_albums

# p (album2.find_artist)[0].find_albums
