move_card <- 
  function(blocks, city, original_block, target_block){
    index_in_blocks <- which(blocks$city==city & blocks$block==original_block)[1]
    if(length(index_in_blocks)==1){
      blocks$block[index_in_blocks] <- target_block
      blocks <- blocks[order(desc(blocks$block)),] 
    }
    return(blocks)
  }