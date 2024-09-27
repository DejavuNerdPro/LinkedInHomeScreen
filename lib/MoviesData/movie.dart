class Movie{

late final int id;
late final String title;
late final int year;
late final List<String> genre;
late final double rating;
late final String director;
late final List<String> actors;
late final String plot;
late final String poster;
late final String trailer;
late final String runtime;
late final String awards;
late final String country;
late final String language;
late final String boxOffice;
late final String production;
late final String website;


Movie({
required this.id,
required this.title,
required this.year,
required this.genre,
required this.rating,
required this.director,
required this.actors,
required this.plot,
required this.poster,
required this.trailer,
required this.runtime,
required this.awards,
required this.country,
required this.boxOffice,
required this.language,
required this.production,
required this.website,
});

factory Movie.fromJson(Map<String,dynamic> json)=>Movie(
  id: json["id"], 
  title: json["title"], 
  year: json["year"], 
  genre: List<String>.from(json["genre"]), 
  rating: json["rating"] is int? json["rating"].toDouble():json["rating"], 
  director: json["director"], 
  actors: List<String>.from(json["actors"]), 
  plot: json["plot"], 
  poster: json["poster"], 
  trailer: json["trailer"], 
  runtime: json["runtime"].toString(), 
  awards: json["awards"], 
  country: json["country"], 
  boxOffice: json["boxOffice"], 
  language: json["language"], 
  production: json["production"], 
  website: json["website"]);


  Map<String,dynamic> toJson()=>{
    "id":id,
    "title":title,
    "year":year,
    "genre":genre,
    "rating":rating,
    "director":director,
    "actors":actors,
    "plot":plot,
    "poster":poster,
    "trailer":trailer,
    "runtime":runtime,
    "awards":awards,
    "country":country,
    "language":language,
    "boxOffice":boxOffice,
    "production":production,
    "website":website
  };

}