draw_card <- 
  function(blocks, city){
    original_block <- blocks$block[which(blocks$city==city)[1]]
    return(move_card(blocks=blocks, 
                     city=city, 
                     original_block=original_block, 
                     target_block=-1L))
  }