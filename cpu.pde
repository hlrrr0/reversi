class Cpu {
	void action(){
		if(turn == WHITE){
			int index= int(random(count_choices(choices(turn))));
			int[] pos = cpu_choice(choices(turn),index); 
			disc.put_disc(pos[0],pos[1]); 
		}
	}
	
	int[] cpu_choice(boolean[][] n,int m){
		int count =0;
		for (int i = 0; i < GRID_WIDTH; i++) {
			for (int j = 0; j < GRID_HEIGHT; j++) {
				if(n[i][j]){
					if(count == m){
						return new int[]{i,j};
					}
					count +=1;
				}
			}
		}
	return null;
	}
}