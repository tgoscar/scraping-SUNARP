install.packages("rvest")
install.packages("XML", dependencies = TRUE)
library(rvest)
library(XML)

setwd("C:/Users/OToledo/Desktop/Pyto. Grandes Exposiciones/sunarp/")


url = "https://www.sunarp.gob.pe/qrelacion-sociedades.asp?cod=180"
download.file(url, destfile = "scrapedpage.html", quiet=TRUE)
content <- read_html("scrapedpage.html")

results <- content %>%  
  html_nodes("div") %>% 
  html_nodes(xpath = "./a") %>% 
  html_attr("href")

for (i in 1:length(results)) {
  #dir=paste0("C:/Users/OToledo/Desktop/Pyto. Grandes Exposiciones/sunarp/",i,"_pd",".pdf")
  dir=paste0(180,"_",i,"_pd",".pdf")
  new_url=paste0("https://www.sunarp.gob.pe/",results[i])
  download.file(new_url, destfile =dir,  mode="wb")
}




for (j in 1:180) {
  
  url = paste0("https://www.sunarp.gob.pe/qrelacion-sociedades.asp?cod=",j)
  try(download.file(url, destfile = "scrapedpage.html", quiet=TRUE))
  try(content <- read_html("scrapedpage.html"))
  
  results <- content %>%  
    html_nodes("div") %>% 
    html_nodes(xpath = "./a") %>% 
    html_attr("href")
  
  results <-unique(results)
  
  for (i in 1:length(results)) {
    #dir=paste0("C:/Users/OToledo/Desktop/Pyto. Grandes Exposiciones/sunarp/",i,"_pd",".pdf")
    dir=paste0(j,"_",i,"_pd",".pdf")
    new_url=paste0("https://www.sunarp.gob.pe/",results[i])
    try(download.file(new_url, destfile =dir,  mode="wb"))
  }
  
}