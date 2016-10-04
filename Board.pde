class Board {
    
  void init_board(){

    for(int x = 0; x < GRID_WIDTH; x++){
      for(int y = 0; y < GRID_HEIGHT; y++){
        cells[x][y] = BLANK;
      }
    }
    
    float cx = (GRID_WIDTH - 1) / 2.0;
    float cy = (GRID_HEIGHT - 1) / 2.0;
    cells[floor(cx)][ceil(cy)] = BLACK;
    cells[ceil(cx)][floor(cy)] = BLACK;
    cells[ceil(cx)][ceil(cy)] = WHITE;
    cells[floor(cx)][floor(cy)] = WHITE;
  }
}