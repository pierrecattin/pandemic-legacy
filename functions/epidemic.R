epidemic <- 
  function(blocks, bottom_city){
    bottom_city_index <- 
      last(which(blocks$city==bottom_city & 
                   blocks$block!=-1))
    blocks$block[bottom_city_index] <- -1
    blocks[blocks$block==-1, "block"] <- max(blocks$block) + 1
    blocks <- blocks[order(desc(blocks$block)),]
    return(blocks)
  }