// FLUflux: a data visualization project to show correlations between
// global disease (SARS, H5N1, H1N1), global mobility, media representation (news)
// and individual responses (blogs).
// By Jihyun Kim and Andres Colubri
// Version: 017

int FIRST_YEAR = 1990;
int LAST_YEAR = 2009;
int LAST_MONTH =5;
int LAST_MONTH_INDEX = (LAST_YEAR - FIRST_YEAR) * 12 + LAST_MONTH;
int NUM_MONTHS = 12 * (LAST_YEAR - FIRST_YEAR + 1);

//standard circle 
float MIN_COUNTRY_CIRCLE_RAD = 8;
float MAX_COUNTRY_CIRCLE_RAD = 8;

//size of mapping box
int mapX = 130;
int mapY = 30;
int mapWidth = 500;
int mapHeight = 370;

//slider box
int tseriesX = 0;
int tseriesY = 450;
int tseriesWidth = 800;
int tseriesHeight = 300;

int tseriesBarHeight = 30;

//Button
int H1N1ButtonX = 800 - 70;
int H1N1ButtonY = 35;
int H1N1ButtonW = 35;
int H1N1ButtonH = 14;
int ButtonCor = 150;
int ButtonLineCor = 100;

//InfoRect 
int InfoRectX = 30;
int InfoRectY = 420;
int InfoRectW = 10;
int InfoRectH = 7; 
int InfoInc = 12;

int selRoute = -1;
int selDisease = -1;
int selCountry = -1;
int selNews = -1;
int selBlogs = -1;

FlightRouteDatabase routesDB;
DiseaseDatabase diseaseDB;

//max line length
float defRouteLength = 150;

float time;
boolean playing = true;
float timeSliderX = 0;
int currentYear, currentMonth;
float timeInc = 0.1; //speed of slider
float selRadius = 4.0;

//etc
PFont font;
PFont nfont;
PImage title;
PImage concept;


void setup()
{
  size(800, 700);
  smooth();

  background(255);

  routesDB = new FlightRouteDatabase("flux2.csv");
  diseaseDB = new DiseaseDatabase("h1n1.csv", "h5n1.csv", "sars.csv", "", "news-h5n1.csv", "news-sars.csv", "", "blogs-h5n1.csv", "blogs-sars.csv"); //news-h5n1.csv
  font = loadFont("Akkurat-Bold-12.vlw");
  nfont = loadFont("AppleBraille-9.vlw");

  title = loadImage("title.png");
  concept = loadImage("concept.png");
}



void draw()
{
  background(255);


  updateTime();

  drawRoutes();
  drawTimeSeries();

  drawButtons();
  image(title, 30, 30);
  image(concept, 30, 65);

}




void mousePressed()
{
  if (insideMap()) selectRoute();
  else if (insideTSeries()) playing = !playing;
  else if (insideH1N1Button()) selectDisease(H1N1);
  else if (insideH5N1Button()) selectDisease(H5N1);
  else if (insideSARSButton()) selectDisease(SARS);
}

void mouseDragged()
{
  if (insideTSeries())
  {
    playing = false;
    time = constrain(map(mouseX, tseriesX, tseriesWidth, 0, NUM_MONTHS), 0, NUM_MONTHS);
  }
}

/*void keyPressed()
 {
 if (key == 's')  
 {
 
 }
 
 }*/

















