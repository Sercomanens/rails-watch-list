require 'cloudinary'

# Assuming you have Cloudinary configured with your cloud name, API key, and API secret
Cloudinary.config do |config|
  config.cloud_name = 'your_cloud_name'
  config.api_key = 'your_api_key'
  config.api_secret = 'your_api_secret'
end

movies_data = [
  { title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9 },
  { title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7 },
  { title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9 },
  { title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0 }
]

movies_data.each do |movie_data|
  movie = Movie.new(title: movie_data[:title], overview: movie_data[:overview], rating: movie_data[:rating])
  if movie_data[:poster_url].present?
    # Check if the image already exists in Cloudinary
    existing_image = Cloudinary::Search.expression("url=#{movie_data[:poster_url]}").execute
    if existing_image['resources'].any?
      # Use the public ID of the existing image
      movie.poster = existing_image['resources'].first['public_id']
    else
      # Upload the poster image to Cloudinary
      uploaded_file = Cloudinary::Uploader.upload(movie_data[:poster_url])
      # Store the Cloudinary public ID in the movie record
      movie.poster = uploaded_file['public_id']
    end
  end
  movie.save
end
