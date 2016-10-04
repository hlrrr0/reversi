class Disc {

	void put_disc(int x,int y) {
    cells[x][y] = turn;
    reverse_line(x,y,turn,-1,-1);
    reverse_line(x,y,turn,0,-1);
    reverse_line(x,y,turn,1,-1);
    reverse_line(x,y,turn,-1,0);
    reverse_line(x,y,turn,1,0);
    reverse_line(x,y,turn,-1,1);
    reverse_line(x,y,turn,0,1);
    reverse_line(x,y,turn,1,1);

    turn = complement_type(turn);
    update_choices();
    next_turn();
	}	

	void draw(){
		float cell_size_w = cell_w * 0.7;
		float cell_size_h = cell_h * 0.7;
		float can_put_mark_size_w = cell_w * 0.15;
		float can_put_mark_size_h = cell_h * 0.15;

		for (int i = 0; i < GRID_WIDTH; i++) {
			int x = cell_w * (i + 1) - cell_w / 2;
			for (int j = 0; j < GRID_HEIGHT; j++) {
				int y = cell_h * (j + 1) - cell_h / 2;

				if (cells[i][j] == WHITE) {
					fill(255);
				} else if (cells[i][j] == BLACK) {
					fill(0);
				} else {
					continue;
				}
				ellipse(x, y, cell_size_w, cell_size_h);
			}
		}

		//can put discs
		if(turn == BLACK){
			fill(0);
			for (int i = 0; i < GRID_WIDTH; i++) {
				float x = cell_w * (i + 1) - cell_w;

				x += cell_w * 0.5;
				for (int j = 0; j < GRID_HEIGHT; j++) {
					float y = cell_h * (j + 1) - cell_h;

					y += cell_h * 0.5;
					if (black_choices[i][j]){
						ellipse(x, y, can_put_mark_size_w, can_put_mark_size_h);
					}
				}
			}
		} else {
			noStroke();
			fill(255);
			for (int i = 0; i < GRID_WIDTH; i++) {
				float x = cell_w * (i + 1) - cell_w;

				x += cell_w * 0.5;

				for (int j = 0; j < GRID_HEIGHT; j++) {
					float y = cell_h * (j + 1) - cell_h;

					y += cell_h * 0.5;
					if (white_choices[i][j]){
						ellipse(x, y, can_put_mark_size_w, can_put_mark_size_h);
					}
				}
			}
		}
	}

	boolean check_can_put(int x,int y, int type){
	  int comp_type = complement_type(type);
	  boolean c =false;
	  if(cells[x][y] != BLANK){
	    return false;
	  }
	  if(x>0 && y>0 && cells[x-1][y-1] == comp_type){
	    //top left
	    c|= look_up_line(x,y,type,-1,-1);
	  }
	  if (y>0 && cells[x][y-1] == comp_type){
	    //top
	    c|= look_up_line(x,y,type,0,-1);
	  }
	  if (x< GRID_WIDTH -1 && y > 0 && cells[x+1][y-1] == comp_type){
	    //top right
	    c|= look_up_line(x,y,type,1,-1);
	  }
	  if (x>0 && cells[x-1][y] == comp_type){
	    //left
	    c|= look_up_line(x,y,type,-1,0);
	  }
	  if (x<GRID_WIDTH -1 && cells[x+1][y] == comp_type){
	    //right
	    c|= look_up_line(x,y,type,1,0);
	  }
	  if (x>0 && y<GRID_HEIGHT -1 && cells[x-1][y+1] == comp_type){
	    //bottom left
	    c|= look_up_line(x,y,type,-1,1);
	  }
	  if (y<GRID_HEIGHT -1 && cells[x][y+1] == comp_type){
	    //bottom
	    c|= look_up_line(x,y,type,0,1);
	  }
	  if (x < GRID_WIDTH -1 && y < GRID_HEIGHT -1 && cells[x+1][y+1] == comp_type){
	    //bottom right
	    c|= look_up_line(x,y,type,1,1);
	  }
	  return c;
	}
}