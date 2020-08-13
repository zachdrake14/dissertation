library(tidyverse)
library(magrittr)
library(jsonlite)
library(httr)
library(here)

key <- "AIzaSyB7lJ3rfPvqYp8xbHGUEkoSEBx86Qy1lls"

nyc_addresses <- read.csv(here('data/city_of_new_york.csv'))
nyc_addresses %<>% 
  mutate(full_address = paste(NUMBER, STREET, POSTCODE))

get_place_id <- function(key, address){

  output <- GET(url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?",
      query = list(
      key = key,
      input = address, 
      inputtype = "textquery"
      )) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE)%>%
    data.frame()

  return(output)

}


place_id_bucket <- data.frame(matrix(ncol=2, nrow=0))
colnames(place_id_bucket) <- c('place_id', 'status')

for (row in 1:nrow(nyc_addresses)) {
  
  address<- nyc_addresses[row,]$full_address
  print(address)
  output <- get_place_id(key=key, address = address)
  place_id_bucket <- rbind(place_id_bucket, output)
  
}


get_place_details <- function(key, place_id){
  
  output <- GET(url = "https://maps.googleapis.com/maps/api/place/details/json?",
      query = list(
      key = key,
      place_id = place_id
      )) %>%
    content(as = "text", encoding = "UTF-8") %>%
    write(file=here(paste0("data/places/",place_id,".json")))
  
}

for (row in 1:nrow(place_id_bucket)){
  place_id <- place_id_bucket[row,]$place_id
  get_place_details(key = key, place_id = place_id)
}
  