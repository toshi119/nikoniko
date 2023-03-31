import processing.video.*;
Movie mov;

ArrayList<String> strings = new ArrayList<String>(); // 流れている文字 
ArrayList<Float> locations_x = new ArrayList<Float>(); // 文字が流れる位置 x座標
ArrayList<Float> locations_y = new ArrayList<Float>(); // 文字が流れる位置 y座標
ArrayList<Character> threads = new ArrayList<Character>(); // 入力している文字

float x, y;
float speed_x;

void setup() {
  mov = new Movie(this, "machen.mp4");
  mov.play();
  mov.read(); 
  fullScreen();
  speed_x = 6;
}


void draw() {
  background(255);
  PImage imgIn = mov;
  image( imgIn, 0, 0 );

  fill(255);
  textSize(50);

  for (int i=0; i<strings.size(); i++) {
    text(strings.get(i), locations_x.get(i), locations_y.get(i));
    // locations.get(i) += speed_x;を使えない
    // 左辺に持ってこれない
    locations_x.set(i, locations_x.get(i)+speed_x);
    //locations_y.set(i, y);
    if (locations_x.get(i) > width) {
      strings.remove(strings.get(i));
      locations_x.remove(locations_x.get(i));
      locations_y.remove(locations_y.get(i));
    }
  }

  // 入力している文字を表示する
  writeLetters();
}

void writeLetters() {
  int sum=0;
  for (int i=0; i<threads.size(); i++) {
    text(threads.get(i), sum, height/5*4);
    sum += textWidth(threads.get(i));
  }
}

void keyPressed() {
  if (key == ENTER) {
    x = 0.0;
    y = random(0, height/5*3);
    String letters = "";
    for (int i=0; i<threads.size(); i++) {
      letters += threads.get(i);
      //locations_y.set(i, y);
    }
    println("Pressed key is", letters);
    strings.add(letters);
    locations_x.add(x);
    locations_y.add(y);
    //locations_y.set(i, random(0, height/5*4));
    threads.clear();
  } else if (key==BACKSPACE||key==DELETE) {
    if (threads.size() > 0) {
      threads.remove(threads.size()-1);
    }
  } else {
    threads.add(key);
  }
}

void movieEvent(Movie m) {
  m.read();
}

void stop() {
  mov.stop();
  super.stop();
}
