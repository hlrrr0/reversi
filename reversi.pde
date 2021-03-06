int GRID_WIDTH = 8;
int GRID_HEIGHT = 8;
int BLANK = 0;
int BLACK = 1;
int WHITE = 2;
int[][] cells;
int turn = BLACK;
boolean[][] black_choices;
boolean[][] white_choices;
PFont f;
boolean game_end;
boolean restart= false;

void start_game(){
  turn = BLACK;
  game_end = false;
  restart = false;
  update_choices();
  next_turn();
}

void setup() {
  size(400, 400);
  f = createFont("SourceCodePro-Regular.ttf", 24);
  textFont(f);
  cells = new int [GRID_WIDTH][GRID_HEIGHT];
  black_choices = new boolean [GRID_WIDTH][GRID_HEIGHT];
  white_choices = new boolean [GRID_WIDTH][GRID_HEIGHT];
  init_board();

  start_game();
}

void mousePressed(){
  int x = mouseX/(width/GRID_WIDTH);
  int y = mouseY/(height/GRID_HEIGHT);

  if(choices(turn)[x][y]){
   put_disc(x,y); 
  }
  if (restart) {
   init_board();
   start_game();
  }
}



void update_choices(){

  for (int i = 0; i < GRID_WIDTH; i = i + 1) {
    for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
      black_choices[i][j] = check_can_put(i,j,BLACK);
      white_choices[i][j] = check_can_put(i,j,WHITE);
    }
  }
}
void next_turn(){
    if(count_choices(choices(turn))==0){
      turn =complement_type(turn) ;
    }

    if(count_choices(black_choices)==0&&count_choices(white_choices)==0){
     game_end = true;
   }
}
void update(int x, int y){
  if(game_end == true){
    if (next_game(width*0.39,height*0.63,90,40)){
      restart = true;
    }
  }else{
    cpu();
  }
}
void cpu(){
  if(turn == WHITE){
    int index= int(random(count_choices(choices(turn))));
    int[] pos = cpu_choice(choices(turn),index); 
    put_disc(pos[0],pos[1]); 
  }
}
int[] cpu_choice(boolean[][] n,int m){
  int count =0;
  for (int i = 0; i < GRID_WIDTH; i = i + 1) {
    for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
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
boolean next_game(float x, float y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
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
int reverse_line(int x, int y,int type, int dx, int dy){
  int count = 0;
  if (!look_up_line(x,y,type,dx,dy)){
    return 0;
  }
  for (
  int i = x + dx,j = y + dy;
  0 <= i&&i < GRID_WIDTH && 0<=j && j <GRID_HEIGHT;
  i = i + dx,j = j + dy){
    if(cells[i][j] == BLANK){
      break;
    }else if (cells[i][j] == type){
      break;
    }else{
      count +=1;
      cells[i][j]=type;
    }
  }
  return count;
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
boolean[][] choices(int type){
  if(type == WHITE){
    return white_choices;
  }else if (type == BLACK){
    return black_choices;
  }else{
    return null;
  }
}


int count_choices(boolean[][] n){
  int count = 0;
  for (int i = 0; i < GRID_WIDTH; i = i + 1) {
    for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
      if(n[i][j] == true){
        count +=1;
      }
    }
  }
  return count;
}

int count_disc(int[][] n,int type){
  int count = 0;
  for (int i = 0; i < GRID_WIDTH; i = i + 1) {
    for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
      if(n[i][j] == type){
        count +=1;
      }
    }
  }
  return count;
}
void draw_result(){
  if(game_end == true){
    fill(0);
    text("[BLACK]:"+count_disc(cells,BLACK),width*0.5,height*0.3);
    text("vs",width*0.5,height*0.35);
    fill(255);
    text("[WHITE]:"+count_disc(cells,WHITE),width*0.5,height*0.4);
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
  update(mouseX,mouseY);
  //clear screen
  background(40,180,40);
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

  noStroke();
  if(turn == BLACK){
    fill(0);
    for (int i = 0; i < GRID_HEIGHT; i = i + 1) {
      float x = cell_h * (i + 1) - cell_h;

      x += cell_w * 0.5;
      for (int j = 0; j < GRID_HEIGHT; j = j + 1) {
        float y = cell_h * (j + 1) - cell_h;

        y += cell_h * 0.5;
        if (black_choices[i][j]){
          ellipse(x, y, cell_w * 0.15, cell_h * 0.15);
        }
      }
    }
  }else{
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
  }
  if (game_end){
    draw_result();
    drawGameEnd();
    draw_retry();
  }
}

void drawGameEnd() {
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