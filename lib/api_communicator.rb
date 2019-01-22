require 'rest-client'
require 'json'
require 'pry'

$api_key = "4d19d52e509a4fab0c5bdf0f538ed2a3"

def get_top_tracks
  JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&limit=100&api_key=#{$api_key}&format=json"))
end

def top_tracks_from_artist(artist)
  JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{artist}&limit=100&api_key=#{$api_key}&format=json"))
end

def top_track_names_from_artist(artist)
  top_tracks_from_artist(artist)["toptracks"]["track"].map {|m| m["name"]}
end

def get_top_artists_names
  parse = JSON.parse(RestClient.get("http://ws.audioscrobbler.com//2.0/?method=chart.gettopartists&limit=100&api_key=#{$api_key}&format=json"))
  parse["artists"]["artist"].map {|m| m["name"]}
end

def song_search_return_name(search)
  search = search.parameterize
  parse = JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=track.search&track=#{search}&api_key=#{$api_key}&format=json"))
  parse = parse["results"]["trackmatches"]["track"][0]
  parse ?  parse["name"] :  nil
end