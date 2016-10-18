int GRID_WIDTH = 8;
int GRID_HEIGHT = 8;
int WIDTH = 400;
int HEIGHT = 400;

Board board = new Board();
Text text = new Text();
Disc disc = new Disc();
Cpu cpu = new Cpu();

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
  disc.update_choices();
  next_turn();
}

void mousePressed(){
  int x = mouseX/(width/GRID_WIDTH);
  int y = mouseY/(height/GRID_HEIGHT);

  if(choices(turn)[x][y]){
   disc.put_disc(x,y); 
  }
  if (restart) {
   board.initialize();
   start_game();
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
    cpu.action();
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

void draw(){
  update(mouseX,mouseY);
  board.draw();
  disc.draw();
  
  if (game_end){
    text.draw_result();
    text.drawGameEnd();
    text.draw_retry();
  }
}