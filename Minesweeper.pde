

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private boolean win = false;
private boolean lose = false;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++)
      for (int c = 0; c < NUM_COLS; c++)
        buttons[r][c]= new MSButton (r,c);
    
    setBombs();
}
public void setBombs()
{   int num = 0;
    while (num < 30) 
    {
      int r = (int)(Math.random() * NUM_ROWS);
      int c = (int)(Math.random() * NUM_ROWS);
      if (!bombs.contains(buttons[r][c]))
      {
        bombs.add(buttons[r][c]);
        num++;
      }
    }
}

public void draw ()
{
    background(225,220,220);
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{  
   int a = 0;
   for (int row=0; row<NUM_ROWS; row++)
    {
      for (int col=0; col<NUM_COLS; col++)
      {
        if (buttons[row][col].isClicked() == false)
            a++;
      }
    }
    if (a ==30)
    {
      return true;
    }
    return false;
}
public void displayLosingMessage()
{
  String losingMessage = "YOU LOST";
  for (int c = 1; c<19; c++)
    buttons[9][c].setLabel(losingMessage.substring(c-1,c));
  win = true;
}
public void displayWinningMessage()
{
   String winningMessage = "YOU WON";
   for (int c=1; c<19; c++)
     buttons[9][c].setLabel(winningMessage.substring(c-1,c));
   lose = true;
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if (keyPressed == true && marked == false)
              clicked = false;
        else if (bombs.contains(this))
              displayLosingMessage();
        else if (countBombs(r,c) >0)
              setLabel("" + countBombs(r,c) + "");
        else
          {
            if(isValid(r+1, c+1) == true && buttons[r+1][c+1].isClicked() == false)
                buttons[r+1][c+1].mousePressed();
            if(isValid(r-1, c-1) == true && buttons[r-1][c-1].isClicked() == false)
                buttons[r-1][c-1].mousePressed();
            if(isValid(r+1, c) == true && buttons[r+1][c].isClicked() == false)
                buttons[r+1][c].mousePressed();
            if(isValid(r, c+1) == true && buttons[r][c+1].isClicked() == false)
                buttons[r][c+1].mousePressed();
            if(isValid(r+1, c-1) == true && buttons[r+1][c-1].isClicked() == false)
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1, c+1) == true && buttons[r-1][c+1].isClicked() == false)
                buttons[r-1][c+1].mousePressed();
            if(isValid(r, c-1) == true && buttons[r][c-1].isClicked() == false)
                buttons[r][c-1].mousePressed();
            if(isValid(r-1, c) == true && buttons[r-1][c].isClicked() == false)
                buttons[r-1][c].mousePressed();
          }
            
        }
    

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
      if (r >=0 && r <20 && c >=0 && c <20)
          return true;
      return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row,col+1) == true && bombs.contains(buttons[r][c+1]))
          numBombs++;
        if (isValid(row,col-1) == true && bombs.contains(buttons[r][c-1]))
          numBombs++;
        if (isValid(row-1,col) == true && bombs.contains(buttons[r-1][c]))
          numBombs++;
        if (isValid(row+1,col) == true && bombs.contains(buttons[r+1][c]))
          numBombs++;
        if (isValid(row+1,col+1) == true && bombs.contains(buttons[r+1][c+1]))
          numBombs++;
        if (isValid(row-1,col-1) == true && bombs.contains(buttons[r-1][c-1]))
          numBombs++;
        if (isValid(row+1,col-1) == true && bombs.contains(buttons[r+1][c-1]))
          numBombs++;
        if (isValid(row-1,col+1) == true && bombs.contains(buttons[r-1][c+1]))
          numBombs++;
        return numBombs;
    }
}