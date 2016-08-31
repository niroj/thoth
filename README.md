# What

Thoth is a webpage scrapper. Supplied with a valid url, it scraps the page for content inside 4 tags(currently).

# How
* send url for indexing
```
  curl http://thoth-web-scraper.herokuapp.com/webpages -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"webpage":{"url":"http://google.com"}}'
```
* see all indexed url
```
  curl http://thoth-web-scraper.herokuapp.com/webpages
```
* see only one indexed url(note: you should know the id)
```
  curl http://thoth-web-scraper.herokuapp.com/webpages/1
```

# Example App
* http://thoth-web-scraper.herokuapp.com
* http://thoth-web-scraper.herokuapp.com/webpages -> all stored webpages
* http://thoth-web-scraper.herokuapp.com/webpages/1 -> individual webpages

# Technology Stack Used
* Rails
* Sidekiq
* PostgreSql
* Redis(by sidekiq)
* [mechanize](https://github.com/sparklemotion/mechanize) to scrap data