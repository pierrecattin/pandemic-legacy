init_blocks <- 
  function(cards){
    nb_cards <- 3*length(unique(cards$city))
    blocks <- 
      tibble(city=character(nb_cards), 
             block=integer(nb_cards))
    row <- 1
    for(i in 1:nrow(cards)){
      blocks$city[row:(row+3-1)] <- cards$city[i]
      
      if(cards$count[i] >0 ){
        ix <- row:(row+cards$count[i]-1)
        blocks$block[ix] <- 0L
      }
      if(cards$count[i] < 3 ){
        ix <- (row+cards$count[i]):(row+3-1)
        blocks$block[ix] <- -2L
      }
      row <- row+3
    }
    return(blocks)
  }