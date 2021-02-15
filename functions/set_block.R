set_block <- 
  function(blocks, city, block){
    index_in_blocks <- which(blocks$city==city)[1]
    blocks$block[index_in_blocks] <- block
    blocks <- blocks[order(desc(blocks$block)),]
    return(blocks)
  }