library(tidyverse)
library(magrittr)
library(jsonlite)
library(httr)

nearby_places_url <- "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?"
places_detail <- "https://maps.googleapis.com/maps/api/place/details/json?"
key <- "AIzaSyB7lJ3rfPvqYp8xbHGUEkoSEBx86Qy1lls"

get_nearbly_places <- GET(url = nearby_places_url,
                          query = list(
                            key = key,
                            input = "2834 Lester Lee Ct, Falls Church, VA", 
                            inputtype = "textquery"
                          ))

response <- content(get_nearbly_places, as = "text", encoding = "UTF-8")

df <- fromJSON(response, flatten = FALSE)

home <- 'ChIJ4aJHU0RLtokRUHUqegwQv6k'

get_places_details <- GET(url = places_detail,
                          query = list(
                            key = key,
                            place_id = home
                          ))


response2 <- content(get_places_details, as = "text", encoding = "UTF-8")

df2 <- fromJSON(response2, flatten = FALSE)
