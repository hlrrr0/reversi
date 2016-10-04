class Disc {
	
	void draw(){
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
				ellipse(x, y, cell_w * 0.7, cell_h * 0.7);
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
						ellipse(x, y, cell_w * 0.15, cell_h * 0.15);
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
						ellipse(x, y, cell_w * 0.15, cell_h * 0.15);
					}
				}
			}
		}
	}
}