library(rvest)
library(dplyr)

get_info = function(book_links) {
  book_page = read_html(book_links)
  book_info = book_page %>% html_nodes("td") %>% html_text() %>% paste(collapse = ",")
  return(book_info)
}

books = data.frame()

for (page_results in seq(from=1, to=5)) {
  link = paste0("https://books.toscrape.com/catalogue/page-",page_results,".html")
  page = read_html(link)
  
  name = page %>% html_nodes("h3") %>% html_text()
  book_links = page %>% html_nodes("h3 a") %>%
    html_attr("href") %>% paste("https://books.toscrape.com/catalogue/", ., sep="" )
  price = page %>% html_nodes((".price_color")) %>% html_text()
  availability = page %>% html_nodes(".availability") %>% html_text()
  
  info = sapply(book_links, FUN = get_info, USE.NAMES = FALSE)
  books = rbind(books, data.frame(name, price, availability, info, stringsAsFactors = FALSE))
  
  print(paste("Page:", page_results))
}


write.csv(books, "scraped_data.csv")

