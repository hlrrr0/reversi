int GRID_WIDTH = 8;
int GRID_HEIGHT = 8;
int WIDTH = 400;
int HEIGHT = 400;
Board board = new Board();
Text text = new Text();
Disc disc = new Disc();

int DEFAULT_FONT_SIZE = 24;

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

int cell_w = (WIDTH/GRID_WIDTH);
int cell_h = (HEIGHT/GRID_HEIGHT);


void setup() {
  size(400, 400);
  f = createFont("SourceCodePro-Regular.ttf", DEFAULT_FONT_SIZE);
  textFont(f);
  cells = new int [GRID_WIDTH][GRID_HEIGHT];
  black_choices = new boolean [GRID_WIDTH][GRID_HEIGHT];
  white_choices = new boolean [GRID_WIDTH][GRID_HEIGHT];
  board.initialize();

  start_game();
}

void start_game(){
  turn = BLACK;
  game_end = false;
  restart = false;
  update_choices();
  next_turn();
}

void mousePressed(){
  int x = mouseX/(width/GRID_WIDTH);
  int y = mouseY/(height/GRID_HEIGHT);

  if(choices(turn)[x][y]){
   put_disc(x,y); 
  }
  if (restart) {
   board.initialize();
   start_game();
  }
}

void update_choices(){

  for (int i = 0; i < GRID_WIDTH; i++) {
    for (int j = 0; j < GRID_HEIGHT; j++) {
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
  if(game_end){
    if (next_game(width*0.39,height*0.63,90,40)){
      restart = true;
    }
  } else {
    cpu();
  }
}

boolean next_game(float x, float y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
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
  for (int i = 0; i < GRID_WIDTH; i++) {
    for (int j = 0; j < GRID_HEIGHT; j++) {
      if(n[i][j] == true){
        count +=1;
      }
    }
  }
  return count;
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
  board.draw();
  disc.draw();
  //draw discs
  
  if (game_end){
    text.draw_result();
    text.drawGameEnd();
    text.draw_retry();
  }
}


