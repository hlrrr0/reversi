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
  //white_choices[4][2]=true;
  //white_choices[5][3]=true;
  //white_choices[0][0]=true;
  //white_choices[7][7]=true;
  //black_choices[3][2]=true;
  //black_choices[2][3]=true;
  //black_choices[0][0]=true;
  //black_choices[7][7]=true;

}

void mousePressed(){
  int x = mouseX/(width/GRID_WIDTH);
  int y = mouseY/(height/GRID_HEIGHT);

  cells[x][y] = (cells[x][y]+1) % 3;
  //cells[x][y] = turn;
  //if (turn == BLACK){
  //  turn = WHITE;
  //}else{
  //  turn = BLACK;
  //}
}



void update_choices(){

  for (int i = 0; i < GRID_WIDTH; i = i + 1) {
    for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
      black_choices[i][j] = check_can_put(i,j,BLACK);
      white_choices[i][j] = check_can_put(i,j,WHITE);
    }
  }
}

boolean look_up_line(int x, int y,int type, int dx, int dy){
  for (
  int i = x + dx,j = y + dy;
  0 <= i&&i < GRID_WIDTH && 0<=j && j <GRID_HEIGHT;
  i = i + dx,j = j + dy){
    if(cells[i][j] == BLANK){
      return false;
    }else if (cells[i][j] == type){
      return true;
    }else{
      continue;
    }
  }
  return false;
}
int complement_type(int type){
  if(type == WHITE){
    return BLACK;
  }else if (type == BLACK){
    return WHITE;
  }else{
    return BLANK;
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

void draw(){
  update_choices();

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
  fill(255);
  for (int i = 0; i < GRID_WIDTH; i = i + 1) {
    float x = cell_w * (i + 1) - cell_w;

    x += cell_w * 0.5;

    for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
      float y = cell_h * (j + 1) - cell_h;

      y += cell_h * 0.5;
      if (white_choices[i][j]){
        ellipse(x, y, cell_w * 0.15, cell_h * 0.15);
      }
    }
  }
  fill(0);
  for (int i = 0; i < GRID_HEIGHT; i = i + 1) {
    float x = cell_h * (i + 1) - cell_h;

    x += cell_w * 0.5;
    for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
      float y = cell_h * (j + 1) - cell_h;

      y += cell_h * 0.5;
      if (black_choices[i][j]){
        if((white_choices[i][j])&&(System.currentTimeMillis()/500) % 2 == 0){
          continue;
        }
        ellipse(x, y, cell_w * 0.15, cell_h * 0.15);
      }
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