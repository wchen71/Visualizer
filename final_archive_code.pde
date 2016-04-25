//Wilson Chen
//April 28, 2016

import ddf.minim.analysis.*; //for fft
import ddf.minim.*; // for audio 

Minim minim; //minim variable
AudioPlayer song; //song vairable

AudioInput in; //mic in

FFT fft; //band(loudness) and frequency
float[] angle; // array of angles
float[] y, x, by, bx, r, g, b, f; //array of sizes, color, fade

int more;
float small, big, hue;

void setup()
{
  size(displayWidth, displayHeight, P3D); //full screen with 3d
  minim = new Minim(this); //new minim 
  song = minim.loadFile("dep.mp3"); //import a song
  //in = minim.getLineIn(Minim.STEREO, 2048, 192000.0);

  fft = new FFT(song.bufferSize(), song.sampleRate()); //fft takes the songs buffersize and samplerate
  more = 2;
  hue = 1;


  //puts in spectrum size (number of frequencies) as number of x and ys
  y = new float[fft.specSize()*more];
  x = new float[fft.specSize()*more];
  by = new float[fft.specSize()*more];
  bx = new float[fft.specSize()*more];
  r = new float[fft.specSize()*more];
  g = new float[fft.specSize()*more];
  b = new float[fft.specSize()*more];
  f  =  new float[fft.specSize()*more];
  angle = new float[fft.specSize()*more];
  for (int i = 0; i < fft.specSize()*more; i++) {
    y[i] = 0; // sets initial size
    x[i] = 120; // sets initial size
    by[i] = 0; // sets initial size
    bx[i] = 240; // sets initial size
    r[i] = random(127, 255);
    g[i] = random(127, 255);
    b[i] = random(127, 255);
    f[i] = random(0, 3);
  }
  small = random(1, 4);
  big = random(30, 50);

  frameRate(240);//makes frame rate
  song.play(); //plays song
}

void draw()
{
  background(0); //background to black
  fft.forward(song.mix); //forward the buffer

  visuals();
}

void visuals() {
  noStroke();//no stroke on boxs
  pushMatrix();//make matrix tranlsations
  translate(width/2, height/2); //center the visualizer
  for (int i = 0; i < fft.specSize()*more; i++) { // for each freqency band
    y[i] = y[i] + fft.getBand(i)/400; // set y to match band ratio: the bigger the number the less chaotic the circles spread
    x[i] = x[i] + fft.getFreq(i)/500; // set x to match frequency ratio: the bigger the number the less expansive the circles spread

    //angle turns based on frequency
    angle[i] = angle[i] + fft.getFreq(i)/10000; //the bigger the number the more connected the circles move
    rotateX(sin(angle[i]/small));
    rotateY(cos(angle[i]/small));

    if (i <= more*fft.specSize()/8) {
      if (f[1] <= 1) {
        fill(r[1], g[1], b[1] + fft.getFreq(i)/hue, 100+fft.getFreq(i)/7 );//color based off of volume and frequenc
      } else if (f[1] <= 2 && f[1] > 1) {
        fill(r[1], g[1]+fft.getFreq(i)/hue, b[1], 100+fft.getFreq(i)/7 );//color based off of volume and frequenc
      } else if (f[1] <= 3 && f[1] > 2) {
        fill(r[1]+fft.getFreq(i)/hue, g[1], b[1], 100+fft.getFreq(i)/7 );//color based off of volume and frequenc
      }
    } else if (i <= more*2*fft.specSize()/8 && i > more*fft.specSize()/8) {
      if (f[2] <= 1) {
        fill(r[2], g[2], b[1]+fft.getFreq(i)/hue, fft.getFreq(i)+100);
      } else if (f[2] <= 2 && f[2] > 1) {
        fill(r[2], g[2]+fft.getFreq(i)/hue, b[2], fft.getFreq(i)+100);
      } else if (f[2] <= 3 && f[2] > 2) {
        fill(r[2]+fft.getFreq(i)/hue, g[2], b[2], fft.getFreq(i)+100);
      }
    } else if (i <= more*3*fft.specSize()/8 && i > more*2*fft.specSize()/8) {
      if (f[3] <= 1) {
        fill(r[3], g[3], b[3]+fft.getFreq(i)/hue, fft.getFreq(i)+100);
      } else if (f[3] <= 2 && f[3] > 1) {
        fill(r[3], g[3]+fft.getFreq(i)/hue, b[3], fft.getFreq(i)+100);
      } else if (f[3] <= 3 && f[3] > 2) {
        fill(r[3]+fft.getFreq(i)/hue, g[3], b[3], fft.getFreq(i)+100);
      }
    } else if (i <= more*4*fft.specSize()/8 && i > more*3*fft.specSize()/8) {
      if (f[4] <= 1) {
        fill(r[4], g[4], b[4]+fft.getFreq(i)/hue, fft.getFreq(i)+100);
      } else if (f[4] <= 2 && f[4] > 1) {
        fill(r[4], g[4]+fft.getFreq(i)/hue, b[4], fft.getFreq(i)+100);
      } else if (f[4] <= 3 && f[4] > 2) {
        fill(r[4]+fft.getFreq(i)/hue, g[4], b[4], fft.getFreq(i)+100);
      }
    } else if (i <= more*5*fft.specSize()/8 && i > more*4*fft.specSize()/8) {
      if (f[5] <= 1) {
        fill(r[5], g[5], b[5]+fft.getFreq(i)/hue, fft.getFreq(i)+100);
      } else if (f[5] <= 2 && f[5] > 1) {
        fill(r[5], g[5]+fft.getFreq(i)/hue, b[5], fft.getFreq(i)+100);
      } else if (f[5] <= 3 && f[5] > 2) {
        fill(r[5]+fft.getFreq(i)/hue, g[5], b[5], fft.getFreq(i)+100);
      }
    } else if (i <= more*6*fft.specSize()/8 && i > more*5*fft.specSize()/8) {
      if (f[6] <= 1) {
        fill(r[6], g[6], b[6]+fft.getFreq(i)/hue, fft.getFreq(i)+100);
      } else if (f[6] <= 2 && f[6] > 1) {
        fill(r[6], g[6]+fft.getFreq(i)/hue, b[6], fft.getFreq(i)+100);
      } else if (f[6] <= 3 && f[6] > 2) {
        fill(r[6]+fft.getFreq(i)/hue, g[6], b[6], fft.getFreq(i)+100);
      }
    } else if (i <= more*7*fft.specSize()/8 && i > more*6*fft.specSize()/8) {
      if (f[7] <= 1) {
        fill(r[7], g[7], b[7]+fft.getFreq(i)/hue, fft.getFreq(i)+100);
      } else if (f[7] <= 2 && f[7] > 1) {
        fill(r[7], g[7]+fft.getFreq(i)/hue, b[7], fft.getFreq(i)+100);
      } else if (f[7] <= 3 && f[7] > 2) {
        fill(r[7]+fft.getFreq(i)/hue, g[7], b[7], fft.getFreq(i)+100);
      }
    } else if (i > more*7*fft.specSize()/8) {
      if (f[8] <= 1) {
        fill(r[8], g[8], b[8]+fft.getFreq(i)/hue, fft.getFreq(i)+100);
      } else if (f[8] <= 2 && f[8] > 1) {
        fill(r[8], g[8]+fft.getFreq(i)/hue, b[8], fft.getFreq(i)+100);
      } else if (f[8] <= 3 && f[8] > 2) {
        fill(r[8]+fft.getFreq(i)/hue, g[8], b[8], fft.getFreq(i)+100);
      }
    } 

    pushMatrix();
    translate((x[i]+40)%width/3, (y[i]+50)%height/3); //matrix size based off of predetermined x,y
    if (i <= more*fft.specSize()/8) {
      box( fft.getFreq(i)/20);//box size based off of band and frequency
    } else if (i > more*fft.specSize()/8 && i <= more*5*fft.specSize()/8) {
      box(fft.getBand(i)/8 + fft.getFreq(i)/8);//box size based off of band and frequency
    } else if (i > more*5*fft.specSize()/8) {
      box(fft.getBand(i)/7 + fft.getFreq(i)/7);
    }
    popMatrix();
  }
  popMatrix();

  pushMatrix();
  translate(width/2, height/5, 0);
  for (int i = 0; i < fft.specSize(); i++) {
    by[i] = by[i] + fft.getBand(i)/50000;
    bx[i] = bx[i] + fft.getFreq(i)/50000;
    angle[i] = angle[i] + fft.getFreq(i)/1000000;
    rotateX(-sin(angle[i]/big));
    rotateY(cos(angle[i]/big));
    fill(r[i], g[i], b[i]);
    pushMatrix();

    translate((bx[i]+250)%width, (by[i])%height+250);

    box(fft.getBand(i)/200+fft.getFreq(i)/150, fft.getBand(i)/200+fft.getFreq(i)/150, 0);
    popMatrix();
  }
  popMatrix();

  pushMatrix();
  translate(width/2, height/5, 0);
  for (int i = 0; i < fft.specSize(); i++) {
    by[i] = by[i] + fft.getBand(i)/50000;
    bx[i] = bx[i] + fft.getFreq(i)/50000;
    angle[i] = angle[i] + fft.getFreq(i)/1000000;
    rotateX(-sin(angle[i]/big));
    rotateY(-cos(angle[i]/big));
    fill(r[i], g[i], b[i]);
    pushMatrix();

    translate((bx[i]+250)%width, (by[i])%height+250);

    box(fft.getBand(i)/200+fft.getFreq(i)/150, fft.getBand(i)/200+fft.getFreq(i)/150, 0);
    popMatrix();
  }
  popMatrix();
}

void stop() {
  song.close();
  minim.stop();
  super.stop();
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      hue=1;
      for (int i = 1; i<9; i++) { //random
        f[i] = random(0, 3);
        r[i] = random(0, 255);
        g[i] = random(0, 255);
        b[i] = random(0, 255);
      }
    } else if (keyCode == DOWN) { //regular
      hue=10;
      r[1] = 255; //red
      g[1] = 0;
      b[1] = 0;
      r[2] = 255; //oj
      g[2] = 165;
      b[2] = 0;
      r[3] = 255; //yellow
      g[3] = 255;
      b[3] = 0;
      r[4] = 0; //grean
      g[4] = 255;
      b[4] = 0;
      r[5] = 0; //cyan
      g[5] = 255;
      b[5] = 255;
      r[6] =0; //blue
      g[6] = 161;
      b[6] = 255;
      r[7] = 255; //purple
      g[7] = 0;
      b[7] = 255;
      r[8] = 221; //light purple
      g[8] = 160;
      b[8] = 221;
    } else if (keyCode == LEFT) {//anagolous
      hue=10;
      r[1] = 255; //red
      g[1] = 0;
      b[1] = 0;
      r[2] = 255; //oj
      g[2] = 0;
      b[2] = 73;
      r[3] = 255; //yellow
      g[3] = 0;
      b[3] = 146;
      r[4] = 255; //grean
      g[4] = 0;
      b[4] = 219;
      r[5] = 219; //cyan
      g[5] = 0;
      b[5] = 255;
      r[6] = 146; //blue
      g[6] = 0;
      b[6] = 255;
      r[7] = 73; //purple
      g[7] = 0;
      b[7] = 255;
      r[8] = 0; //light purple
      g[8] = 0;
      b[8] = 255;
    } else if (keyCode == RIGHT) { //white
      for (int i = 1; i<9; i++) { 
        f[i] = random(0, 3);
        r[i] = 255;
        g[i] =255;
        b[i] =255;
      }
    }
  }
}