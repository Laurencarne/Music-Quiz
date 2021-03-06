require 'rest-client'
require 'json'
require 'pry'

$api_key = "4d19d52e509a4fab0c5bdf0f538ed2a3"

def get_top_tracks
  JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&limit=100&api_key=#{$api_key}&format=json"))["tracks"]["track"].map{|t| t["name"]}
end


def get_top_artists_names
  parse = JSON.parse(RestClient.get("http://ws.audioscrobbler.com//2.0/?method=chart.gettopartists&limit=30&api_key=#{$api_key}&format=json"))
  parse["artists"]["artist"].map {|m| m["name"]}
end

def song_search_return_name(search, artist)
  search = search.gsub(" ", "%20").mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'')
  artist = artist.gsub(" ", "%20").mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'')
  parse = JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=track.getcorrection&artist=#{artist}&track=#{search}&api_key=#{$api_key}&format=json"))
  if parse["corrections"]["correction"]
    return parse["corrections"]["correction"]["track"]["name"] #returns string of name
  else
    return nil
  end
end

def check_artists(artist)
  artist = artist.gsub(" ", "%20").mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'')
  parse = JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=artist.getcorrection&artist=#{artist}&api_key=#{$api_key}&format=json"))
  if parse["corrections"]["correction"]
    return parse["corrections"]["correction"]["artist"]["name"].mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'')
  else
    return nil
  end
end
