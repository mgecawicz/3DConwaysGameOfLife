
import peasy.*;

PeasyCam cam;
int dem = 80;
Cell[][][] grid = new Cell[dem][dem][dem];
void setup() {
  fullScreen(P3D);
  for (int i = 0; i < dem; i++) {
    for (int j = 0; j < dem; j++) {
      for (int k = 0; k < dem; k++) {
        boolean m = int(random(90)) == 1 ? true : false;
        grid[i][j][k] = new Cell(i, j, k, m);
      }
    }
  }
  cam = new PeasyCam(this, 200);
  cam.setMinimumDistance(11);
  cam.setMaximumDistance(1000);
}
void draw() {
  rotateX(-1);
  rotateY(1);
  rotateZ(1);
  background(0);
  for (int i = 1; i < dem-1; i++) {
    for (int j = 1; j < dem-1; j++) {
      for (int k = 1; k < dem-1; k++) {
        Cell[] N = {
          grid[i - 1][j - 1][k-1],
          grid[i][j - 1][k-1],
          grid[i + 1][j - 1][k-1],
          grid[i + 1][j][k-1],
          grid[i + 1][j + 1][k-1],
          grid[i][j + 1][k-1],
          grid[i - 1][j + 1][k-1],
          grid[i - 1][j][k-1],

          grid[i - 1][j - 1][k],
          grid[i][j - 1][k],
          grid[i + 1][j - 1][k],
          grid[i + 1][j][k],
          grid[i + 1][j + 1][k],
          grid[i][j + 1][k],
          grid[i - 1][j + 1][k],
          grid[i - 1][j][k],

          grid[i - 1][j - 1][k-1],
          grid[i][j - 1][k-1],
          grid[i + 1][j - 1][k-1],
          grid[i + 1][j][k-1],
          grid[i + 1][j + 1][k-1],
          grid[i][j + 1][k-1],
          grid[i - 1][j + 1][k-1],
          grid[i - 1][j][k-1],

          grid[i - 1][j - 1][k+1],
          grid[i][j - 1][k+1],
          grid[i + 1][j - 1][k+1],
          grid[i + 1][j][k+1],
          grid[i + 1][j + 1][k+1],
          grid[i][j + 1][k+1],
          grid[i - 1][j + 1][k+1],
          grid[i - 1][j][k+1]
        };
        grid[i][j][k].show(4);
        grid[i][j][k].cycle(N);
        
      }
    }
  }
}

class Cell {
  PVector pos;
  boolean alive;
  Cell(int x, int y, int z, boolean state) {
    pos = new PVector(x, y, z);
    alive = state;
  }
  void die() {
    alive = false;
  }
  void live() {
    alive = true;
  }
  int numN(Cell[] N) {
    int total = 0;
    for (int i = 0; i < N.length; i++) {
      if (N[i].alive) {
        total++;
      }
    }
    return total;
  }
  void cycle(Cell[] N) {
    int num = numN(N);
    if (alive && num < 2) {
      die();
    } else if (alive && (num == 3 || num == 4)) {
      live();
    } else if (alive && num > 5) {
      die();
    } else if (!alive && num == 5) {
      live();
    }
  }
  void show(int scaler) {
    pushMatrix();
    if (alive) {
      translate(pos.x*scaler, pos.y*scaler, pos.z*scaler);
      fill(abs(pos.x)+180, abs(pos.y)+180, abs(pos.z)+180);
      noStroke();
      box(4);
    }
    popMatrix();
  }
}
