class Text {
	
	int count_disc(int[][] n,int type){
	  int count = 0;
	  for (int i = 0; i < GRID_WIDTH; i++) {
	    for (int j = 0; j < GRID_HEIGHT; j++) {
	      if(n[i][j] == type){
	        count +=1;
	      }
	    }
	  }
	  return count;
	}

	void draw_result(){
		fill(0);
		text("[BLACK]:"+count_disc(cells,BLACK),width*0.5,height*0.3);
		text("vs",width*0.5,height*0.35);
		fill(255);
		text("[WHITE]:"+count_disc(cells,WHITE),width*0.5,height*0.4);
	}

	void drawGameEnd(){
		textAlign(CENTER);

		fill(255,0,0);
		text("GAME END", width*0.5, height*0.5);
	}

	void draw_retry(){
		fill(0);
		rect(width*0.39,height*0.63,90,40);
		fill(255);
		text("ReTry", width*0.5, height*0.7);
	}
}