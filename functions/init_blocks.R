init_blocks <- 
  function(cards){
    nb_cards <- sum(cards$count)
    blocks <- 
      tibble(city=character(nb_cards), 
             block=rep(0L,nb_cards))
    row <- 1
    for(i in 1:nrow(cards)){
      if(cards$count[i]>0){
        blocks$city[row:(row+cards$count[i]-1)] <- cards$city[i]
        row <- row+cards$count[i]
      }
    }
    return(blocks)
  }