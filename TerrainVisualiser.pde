/*   
     AUDIO INPUT - VISUALIZER
     By Will Simpson
     
     Thanks to code train and minim library for inspiration and getting me started
     
     Choose an audio input source and change the mixerInfo[] value in line 33
     
     Change the img in loadImage for different background or image or set background as color,
     remember that in order to use an image for background the window must be same size as the image file
     
*/

import ddf.minim.*;
import javax.sound.sampled.*;

Minim minim;
AudioInput in;
Mixer.Info[] mixerInfo;

int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;
float[][] terrain;
float flying =0;

PImage img;

void setup()
{
  //replace this image with any you want for the display
  img = loadImage("img.jpg");
  size(800, 1067, P3D);
  minim = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();
  Mixer mixer = AudioSystem.getMixer(mixerInfo[5]);
  //This value can change depending on what Audio interface is plugged in, use print to debug
  //println(mixerInfo[5]);
  minim.setInputMixer(mixer);
  in = minim.getLineIn(Minim.STEREO);
  frameRate(10);
  cols = w / scl;
  rows = h/scl;
  terrain = new float[cols][rows];
}

void draw() {
  float yoff = flying;
  for (int y =0; y< rows; y++) {
    float xoff =0;
    for (int x=0; x <cols; x++) {
      terrain[x][y] = map(noise(xoff,yoff),0,1,-100,in.left.get(x)*500);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  flying = flying -1;
  
  background(img);
  stroke(195, 132, 234,19);
  //noStroke();
  fill(233,45,74,80);
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y =0; y< rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x=0; x <cols; x++) {
      
      //println(terrain[x][y]);
      vertex(x*scl, y*scl,terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}
