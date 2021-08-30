import java.util.Stack;

int w = 100; 

class Spot
{
  int x;
  int y;
  boolean[] walls;
  
  Spot(int x, int y)
  {
    this.x = x;
    this.y = y;
    walls = new boolean[]{true, true, true, true};
  }
}

class Pair
{
  int i;
  int j;
  ArrayList<Pair> neighbours;
  
  Pair(int i, int j)
  {
    this.i = i;
    this.j = j;
    neighbours = new ArrayList<Pair>();
  }
}
int rows = 600/w;
int cols = 600/w;
Spot[][] grid = new Spot[rows][cols];
boolean[][] visited = new boolean[rows][cols];
boolean[][] non = new boolean[rows][cols];
Pair current = new Pair(0,0);
Stack<Pair> stack = new Stack<Pair>();

void setup()
{
  frameRate(10);
  size(600, 600);
  background(#FFFFFF);
  for(int i=0; i<rows; i++)
  {
    for(int j=0; j<cols; j++)
    {      
      grid[i][j] = new Spot(i*w, j*w);
    }
  }
  stack.push(current);
}

void draw()
{
  // generator();
  background(#FFFFFF);
  noFill();
  stroke(#000000);
  for(int i=0; i<rows; i++)
  {
    for(int j=0; j<cols; j++)
    {
      if(current.i == i && current.j == j)
      {
        fill(#5EADF0);
        noStroke();
        rect(i*w, j*w, w, w);
        continue;
      }
      if(visited[i][j])
      {
        fill(#A4F05E);
        noStroke();
        rect(i*w, j*w, w, w);
      }
      noFill();
      stroke(#000000);
      if(grid[i][j].walls[0])
        line(grid[i][j].x, grid[i][j].y, grid[i][j].x+w, grid[i][j].y);
      if(grid[i][j].walls[1])
        line(grid[i][j].x+w, grid[i][j].y, grid[i][j].x+w, grid[i][j].y+w);
      if(grid[i][j].walls[2])
        line(grid[i][j].x+w, grid[i][j].y+w, grid[i][j].x, grid[i][j].y+w);
      if(grid[i][j].walls[3])
        line(grid[i][j].x, grid[i][j].y, grid[i][j].x, grid[i][j].y+w);
    }
  }
  System.out.println(stack.size());
  visited[current.i][current.j] = true;
  Pair next = findNeighbour(current);
  System.out.println(current.neighbours.size());
  if(next.i !=-1)
  {
    visited[next.i][next.j] = true;
    stack.push(current);
    removeWalls(current, next);
    current = next;
  }
  else 
  {
    non[current.i][current.j] = true;
    while(!stack.isEmpty())
    {
      Pair a = stack.pop();
      if(non[a.i][a.j])
        continue;
      else
      {
        current = a;
        break;
      }
    }
    if(stack.isEmpty())
      noLoop();
  }
}

Pair findNeighbour(Pair current)
  {
    int i = current.i;
    int j = current.j;
    if(i>0 && !visited[i-1][j])
      current.neighbours.add(new Pair(i-1, j));
    if(i<cols-1 && !visited[i+1][j])
      current.neighbours.add(new Pair(i+1, j));
    if(j>0 && !visited[i][j-1])
      current.neighbours.add(new Pair(i, j-1));
    if(j<rows-1 && !visited[i][j+1])
      current.neighbours.add(new Pair(i, j+1));
  
  if(current.neighbours.size()>0)
  {
    return current.neighbours.get((int) (Math.random()*current.neighbours.size()));
  }
  else 
    return new Pair(-1,-1);
  }

void removeWalls(Pair current, Pair next)
{
  int dx = next.i - current.i;
  int dy = next.j - current.j;
  if(dx == 1)
  {
    grid[current.i][current.j].walls[1] = false;
    grid[next.i][next.j].walls[3] = false;
  }
  else if(dx == -1)
  {
    grid[current.i][current.j].walls[3] = false;
    grid[next.i][next.j].walls[1] = false;
  }
  else if(dy == 1)
  {
    grid[current.i][current.j].walls[2] = false;
    grid[next.i][next.j].walls[0] = false;
  }
  else if(dy == -1)
  {
    grid[current.i][current.j].walls[0] = false;
    grid[next.i][next.j].walls[2] = false;
  }
}

void generator()
{
  
}
