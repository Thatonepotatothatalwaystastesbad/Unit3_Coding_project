import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect k;
KinectTracker tracker;
PImage paintImg;
float widthScale;
float heightScale;


void setup()
{
  fullScreen();
  k = new Kinect(this);
  tracker = new KinectTracker();
  k.setTilt(0);
  paintImg = createImage(width, height, RGB);
  widthScale = width/k.width;
  heightScale = height/k.height;
}

void draw()
{
 // background(0);
  tracker.track();
  // Show the image


  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);

  // Display some information
  int t = tracker.getThreshold();  // This is how 
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
    
  float scaledX = map(v2.x, 0, k.width,  0, width);
  float scaledY = map(v2.y, 0, k.height, 0, height);
  paintImage(scaledX, scaledY, 3);
  //paintImg.set(scaledX, scaledY, color(256,0,256));
  //paintImg.pixels[int(v2.y * k.width + v2.x)] = #FF0000;
  image(paintImg, width/2 - paintImg.width/2, height/2 - paintImg.height/2);
  //rect(width/2-paintImg.width/2, height/2 - paintImg.height/2,2,2);
  tracker.display();
  //image(k.getVideoImage(), 0,0);
}

void paintImage(float posX, float posY, int brushSize)
{
  for(int x=(int)posX - brushSize; x < posX + brushSize; x++)
  {
    for (int y = (int)posY - brushSize; y < posY + brushSize; y++)
    {
      paintImg.set(x, y,color(256,0,256));
    }
  }
}

void keyPressed() 
{
  int t = tracker.getThreshold();
    if (keyCode == UP) 
    {
      t+=5;
      tracker.setThreshold(t);
    } 
    else if (keyCode == DOWN) 
    {
      t-=5;
      tracker.setThreshold(t);
    }
    else if ( keyCode == 'c')
    {
      clearImage();
    }
}

void clearImage()
{
  for (int i = 0; i < width*height; i++)
  {
      //paintImg.set(x, y, color(0) );
  }
}