init_blocks <- 
  function(cards){
    nb_cards <- sum(cards$count)
    blocks <- 
      tibble(city=character(nb_cards), 
             block=rep(0L,nb_cards))
    row <- 1
    for(i in 1:nrow(cards)){
      for(j in 1:cards$count[i]){
        blocks$city[row] <- cards$city[i]
        row <- row+1
      }
    }
    return(blocks)
  }