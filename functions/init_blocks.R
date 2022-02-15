init_blocks <- 
  function(cards){
    nb_cards <- sum(cards$in_deck+cards$in_reserve+cards$in_discard)
    blocks <- 
      tibble(city=character(nb_cards), 
             block=integer(nb_cards))
    row <- 1
    for(i in 1:nrow(cards)){
      in_deck <- cards$in_deck[i]
      in_reserve <- cards$in_reserve[i]
      in_discard <- cards$in_discard[i]
      
      if(in_deck+in_reserve+in_discard>0){
        blocks$city[row:(row+in_deck+in_reserve+in_discard-1)] <- cards$city[i]
      }
      
      if(in_deck>0){
        blocks$block[row:(row+in_deck-1)] <- 0L
        row <- row+in_deck
      }
      
      if(in_reserve>0){
        blocks$block[row:(row+in_reserve-1)] <- -2L
        row <- row+in_reserve
      }
      
      if(in_discard>0){
        blocks$block[row:(row+in_discard-1)] <- -1L
        row <- row+in_discard
      }
    }
    return(blocks)
  }