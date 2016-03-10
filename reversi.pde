int GRID_WIDTH = 8;
int GRID_HEIGHT = 8;
int BLANK = 0;
int BLACK = 1;
int WHITE = 2;
int[][] cells;
int turn = BLACK;
boolean[][] black_choices;
boolean[][] white_choices;

void setup() {
  size(400, 400);
  cells = new int [GRID_WIDTH][GRID_HEIGHT];
  black_choices = new boolean [GRID_WIDTH][GRID_HEIGHT];
  white_choices = new boolean [GRID_WIDTH][GRID_HEIGHT];
  init_board();
  //set_fill_patern();
}

void mousePressed(){
  int x = mouseX/(width/GRID_WIDTH);
  int y = mouseY/(height/GRID_HEIGHT);
  
  //cells[x][y] = (cells[x][y]+1) % 3;
  cells[x][y] = turn;
  if (turn == BLACK){
    turn = WHITE;
  }else{
    turn = BLACK;
  }
}














void draw() {
  //clear screen
  background(200);
  int cell_w = width / GRID_WIDTH;
  int cell_h = height / GRID_HEIGHT;
  
  
  stroke(0);
  
  //draw grid(vartical)
  for (int i = 0; i < GRID_WIDTH - 1; i = i + 1) {
    int x = cell_w * (i + 1);
    line(x, 0, x, height);
  }

  //draw grid(horizontal)
  for (int i = 0; i < GRID_HEIGHT - 1; i = i + 1) {
    int y = cell_h * (i + 1);
    line(0, y, width, y);
  }
  
  //draw discs
  for (int i = 0; i < GRID_WIDTH; i = i + 1) {
   int x = cell_w * (i + 1) - cell_w / 2;
   for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
     int y = cell_h * (j + 1) - cell_h / 2;
           
      if (cells[i][j] == WHITE){
        fill(255);
      } else if (cells[i][j] == BLACK){
        fill(0);
      } else {
        continue;
      } 
      ellipse(x, y, cell_w * 0.7, cell_h * 0.7);
    }
  }
  
    //
    noStroke();
  for (int i = 0; i < GRID_WIDTH; i = i + 1) {
    float x = cell_w * (i + 1) - cell_w;
    
      x += cell_w * 0.9;
    
     for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
       float y = cell_h * (j + 1) - cell_h;
     
       y += cell_h * 0.1;        
      if (white_choices[i][j]){
        ellipse(x, y, cell_w * 0.15, cell_h * 0.15);
      }
   }
  }
  for (int i = 0; i < GRID_HEIGHT; i = i + 1) {
   float x = cell_h * (i + 1) - cell_h;
     
     x += cell_w * 0.1;
    for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
      float y = cell_h * (j + 1) - cell_h;
       
        y += cell_h * 0.1;
     if (black_choices[i][j]){
       fill(0);
     }   else {
       continue;
     } 
     ellipse(x, y, cell_w * 0.15, cell_h * 0.15);
  }
  }
}

void set_fill_patern(){
  cells[1][0]=WHITE;
  cells[2][0]=BLACK;
  cells[0][1]=BLACK;
  cells[2][1]=WHITE;
  cells[1][2]=WHITE;
  cells[2][2]=BLACK;
  cells[3][2]=WHITE;
  cells[0][3]=WHITE;
  cells[1][3]=BLACK;
  cells[2][3]=BLACK;
}

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