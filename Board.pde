class Board {

  void draw(){
    background(40,180,40);
    stroke(0);
    
    //draw grid(vartical)
    for (int i = 0; i < GRID_WIDTH - 1; i++) {
      int x = cell_w * (i + 1);
      line(x, 0, x, height);
    }

    //draw grid(horizontal)
    for (int j = 0; j < GRID_HEIGHT - 1; j++) {
      int y = cell_h * (j + 1);
      line(0, y, width, y);
    }
  }
    
  void initialize(){

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