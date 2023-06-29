//klasy pilki oraz paletek
class Ball {
  float x,y,speedX,speedY,srednica;
  color kolor;
//Funkcja initializacji piłki
  Ball(float tempX, float tempY, float tempSrednica) {
    x = tempX;
    y = tempY;
    srednica = tempSrednica;
    speedX = 0;
    speedY = 0;
    kolor = (225); 
  }
//Obsługa ruchu pilki  
  void ruch() {
    y = y + speedY;
    x = x + speedX;
  }
//Aktualizacja pilki jako wyswietlanie  
  void wyswietlanie() {
    fill(kolor);
    ellipse(x,y,srednica,srednica);
  }
//pomocnicze
  float lewo(){
    return x-srednica/2;
  }
  float prawo(){
    return x+srednica/2;
  }
  float gora(){
    return y-srednica/2;
  }
  float dol(){
    return y+srednica/2;
  }
}

class Paddle{
  float x,y,w,h,speedY,speedX;
  color kolor;
//Funkcja initializacji paletek  
  Paddle(float tempX, float tempY, float tempW, float tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    speedY = 0;
    speedX = 0;
    kolor=(255);
  }
//Obsługa ruchu paletek
  void ruch(){
    y = y + speedY;
    x = x + speedX;
  }
//Aktualizacja p[aletek jako wyswietlanie  
  void wyswietlanie(){
    fill(kolor);
    rect(x-w/2,y-h/2,w,h);
  } 
//pomocnicze
  float lewo(){
    return x-w/2;
  }
  float prawo(){
    return x+w/2;
  }
  float gora(){
    return y-h/2;
  }
  float dol(){
    return y+h/2;
  }
}
// Definiowanie ogólnych zmiennych
Ball pilka;
int Wynik_gracz_pierwszy = 0;
int Wynik_gracz_drugi = 0;
Paddle paletka_gracz_pierwszy;
Paddle paletka_gracz_drugi;
//Inicjalizacja gry oraz paletek i pilki
void setup(){
  size(1024, 800);
  pilka = new Ball(width/2, height/2, 50); 
  pilka.speedX = 2;
  pilka.speedY = random(-5,5); 
  paletka_gracz_pierwszy = new Paddle(15, height/2, 30,200);
  paletka_gracz_drugi = new Paddle(width-15, height/2, 30,200);
}
//Restart pozycji piłki po zdobyciu punktu
void restart() {
  pilka.x = width/2;
  pilka.y = height/2;
}
//Sama właściwa gra
void draw(){
  background(450); //Niebieskie tło planszy
  pilka.wyswietlanie();
  pilka.ruch();
  paletka_gracz_pierwszy.wyswietlanie();
  paletka_gracz_pierwszy.ruch();
  paletka_gracz_drugi.wyswietlanie();
  paletka_gracz_drugi.ruch();
//Obsługa wyników
  if (pilka.lewo() > width) {
    Wynik_gracz_pierwszy = Wynik_gracz_pierwszy + 1;
    restart();
  }
  if (pilka.prawo() < 0) {
    Wynik_gracz_drugi = Wynik_gracz_drugi + 1;
    restart();
  }
//Obsługa piłki
  if (pilka.dol() > height) {
    pilka.speedY = -pilka.speedY;
  }
  if (pilka.gora() < 0) {
    pilka.speedY = -pilka.speedY;
  }
//Obsługa paletek  
  if (paletka_gracz_pierwszy.dol() > height) {
    paletka_gracz_pierwszy.y = height-paletka_gracz_pierwszy.h/2;
  }
  if (paletka_gracz_pierwszy.gora() < 0) {
    paletka_gracz_pierwszy.y = paletka_gracz_pierwszy.h/2;
  }
  if ( paletka_gracz_drugi.dol() > height) {
     paletka_gracz_drugi.y = height- paletka_gracz_drugi.h/2;
  }
  if ( paletka_gracz_drugi.gora() < 0) {
     paletka_gracz_drugi.y =  paletka_gracz_drugi.h/2;
  }  
//Obsługa odbicia piłeczek
  if ( pilka.lewo() < paletka_gracz_pierwszy.prawo() && pilka.y > paletka_gracz_pierwszy.gora() && pilka.y < paletka_gracz_pierwszy.dol()){
    pilka.speedX = -pilka.speedX;
    pilka.speedY = map(pilka.y - paletka_gracz_pierwszy.y, -paletka_gracz_pierwszy.h/2, paletka_gracz_pierwszy.h/2, -10, 10);
  }
  if ( pilka.prawo() >  paletka_gracz_drugi.lewo() && pilka.y >  paletka_gracz_drugi.gora() && pilka.y <  paletka_gracz_drugi.dol()) {
    pilka.speedX = -pilka.speedX;
    pilka.speedY = map(pilka.y -  paletka_gracz_drugi.y, - paletka_gracz_drugi.h/2,  paletka_gracz_drugi.h/2, -10, 10);
  }
//Tabela wyników
  textSize(60);
  textAlign(CENTER);
  text(Wynik_gracz_pierwszy, width/2+30, 60);
  text(Wynik_gracz_drugi, width/2-30, 60);
}
//Obsługa sterowania
void keyPressed(){
  if(keyCode == UP){
     paletka_gracz_drugi.speedY=-5;
  }
  if(keyCode == DOWN){
     paletka_gracz_drugi.speedY=5;
  }
  if(key == 'w'){
    paletka_gracz_pierwszy.speedY=-5;
  }
  if(key == 's'){
    paletka_gracz_pierwszy.speedY=5;
  }
}
void keyReleased(){
  if(keyCode == UP){
     paletka_gracz_drugi.speedY=0;
  }
  if(keyCode == DOWN){
     paletka_gracz_drugi.speedY=0;
  }
  if(key == 'w'){
    paletka_gracz_pierwszy.speedY=0;
  }
  if(key == 's'){
    paletka_gracz_pierwszy.speedY=0;
  }
}
