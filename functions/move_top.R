move_top <- 
  function(blocks, city, block){
    index_in_blocks <- which(blocks$city==city & blocks$block==block)[1]
    blocks$block[index_in_blocks] <- max(blocks$block + 1L)
    blocks <- blocks[order(desc(blocks$block)),]
    return(blocks)
  }