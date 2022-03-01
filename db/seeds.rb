# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)
# Movie.create(title: "Lord of Ther Rings: The Fellowship of the Ring", overview: "Best movies in the world", poster_url: "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg", rating: 9.8)
# Movie.create(title: "Lord of Ther Rings: The Two Towers", overview: "Best movies in the world", poster_url: "https://www.oficialhostgeek.com.br/wp-content/uploads/2020/12/zzzz-scaled.jpg", rating: 9.9)
# Movie.create(title: "Lord of Ther Rings: The Return of the King", overview: "Best movies in the world", poster_url: "https://upload.wikimedia.org/wikipedia/pt/0/0d/EsdlaIII.jpg", rating: 10.0)

require 'httparty'

poster_image_url = 'https://image.tmdb.org/t/p/w500'
url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['TMDB_KEY']}&language=en-US&page="

puts '=' * 20
puts 'Creating movies'
puts '=' * 20

20.times do |i|
  response = HTTParty.get("#{url}#{i + 1}")
  movies_data = response.parsed_response['results']

  movies_data.each do |movie|
    next unless Movie.where(title: movie['title']).empty?

    new_movie = Movie.create!(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{poster_image_url}#{movie['poster_path']}",
      rating: movie['vote_average']
    )

    puts "#{new_movie.title} created."
  end
end

puts "#{Movie.count} movies created!"
puts 'Seeds done'
