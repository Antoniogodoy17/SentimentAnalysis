packages = c("ROAuth","twitteR","base64enc","httr","devtools","tm","wordcloud")
for(lib in packages){
  if(!require(lib)){
    install.packages(lib)
  }
}
lapply(packages, library, character.only=TRUE)

#install.packages("twitteR")
#install.packages("ROAuth")
#yes1install.packages("base64enc")
#install.packages("devtools")
# install.packages("tm")
# install.packages("wordcloud")
#devtools::install_version("httr", version="0.6.0", repos="http://cran.us.r-project.org")

# library(ROAuth)
# library(twitteR)
# library(base64enc)
# library(httr)
# library(devtools)
# library(tm)
# library(wordcloud)

#install.packages("httr", dependencies = TRUE)
#devtools::install_version("httr", version="1.0.0", repos="http://cran.us.r-project.org")

#Realizar autenticaci�n con Twitter
api_key = "Y5fbQA5lJodmk0E4q4c1DYbXD"
api_secret = "f4OQTcDmCg56EiHEaSZ7Zo3POHrEn2T0QHj0KbqBmZyRWmNkVL"
access_token = "919998032938012672-6GP05oGCs1SZ6cwP9QwXw8VWulKDXDe"
access_token_secret = "YWOmWI4B3UTzOeYMVyipwVtiQvzIqygfO2cN2ySd1RZk4"
request_url = 'https://api.twitter.com/oauth/request_token'
access_url = 'https://api.twitter.com/oauth/access_token'
auth_url = 'https://api.twitter.com/oauth/authorize'

#Realizar autenticaci�n de la app
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

#Obtener credencial
credential = OAuthFactory$new(consumerKey=api_key,
                              consumerSecret=api_secret,
                              requestURL=request_url,
                              accessURL=access_url,
                              authURL=auth_url)

#Autorizar credencial de la app
credential$handshake(cainfo = system.file("CurlSSL","cacert.pem",package ="RCurl"))

#Buscar y extraer tweets
x = searchTwitter("trump",n=100,lang="en",resultType = "recent")
x

#Convertir lista a vector
tweet = sapply(x, function(x) x$getText())

#Trasnformar a corpus
tweetCorpus = Corpus(VectorSource(tweet))
inspect(tweetCorpus[1])

#Quitar signos de puntuaci�n
tweetsClean = tm_map(tweetCorpus,removePunctuation)

#Transformar todo a min�sculas
tweetsClean = tm_map(tweetsClean,content_transformer(tolower))
inspect(tweetsClean[1])