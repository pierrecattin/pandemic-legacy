epidemic <- 
  function(blocks, bottom_city, from_reserve=FALSE){

    if(!from_reserve){
      bottom_city_block <- 
        blocks$block[last(which(blocks$city==bottom_city & 
                                  blocks$block>=0L))]
    } else {
      bottom_city_block <- -2L
    }
    blocks <- move_card(blocks=blocks, 
                        city=bottom_city, 
                        original_block=bottom_city_block, 
                        target_block=-1L)
    
    blocks[blocks$block==-1, "block"] <- max(blocks$block) + 1L
    blocks <- blocks[order(desc(blocks$block)),]
    return(blocks)
  }