
void drawButtons()
{




  //information 
  fill(70);
  textFont(font, 8);
  text("Numbers of", InfoRectX, InfoRectY - 7);

  textFont(nfont, 8);

  fill(235,0,0);
  rect(InfoRectX, InfoRectY, InfoRectW, InfoRectH);
  text("Diseases", InfoRectX+12, InfoRectY+7);

  fill(70, 200, 50);
  rect(InfoRectX, InfoRectY+ InfoInc, InfoRectW, InfoRectH);
  text("News", InfoRectX+12, InfoRectY+7 + InfoInc);

  fill(100,74,200);
  rect(InfoRectX, InfoRectY+ (InfoInc *2), InfoRectW, InfoRectH);
  text("Blogs", InfoRectX+12, InfoRectY+7 + (InfoInc *2));

  fill(75, 95, 255);
  rect(InfoRectX, InfoRectY +(InfoInc *3), InfoRectW,InfoRectH);
  text("Incoming Passengers from Countries", InfoRectX +12, InfoRectY+7 +(InfoInc *3));

  fill(15, 105, 150);
  rect(InfoRectX, InfoRectY +(InfoInc *4), InfoRectW,InfoRectH);
  text("Outgoing Passengers from US", InfoRectX +12, InfoRectY+7 +(InfoInc *4));




  textFont(nfont,10);
  fill(100);
  strokeWeight(0.5);
  stroke(ButtonLineCor);
  line (H1N1ButtonX-100, H1N1ButtonY+17, 800 -35, H1N1ButtonY+17);
  // line (30, H1N1ButtonY+20, 140, H1N1ButtonY+20);
  text("Select a Disease", H1N1ButtonX-45,H1N1ButtonY+27);

  if (-1 < selDisease)
  {
    fill(220);
    text("Select a Disease", H1N1ButtonX-45,H1N1ButtonY+27);
    fill(100);
    text("Select a Country", H1N1ButtonX-45,H1N1ButtonY+37);
  }

  noStroke();

  textFont(font, 11);
  if (selDisease == H1N1) fill(237, 50, 50);  
  else fill(59, 73, 88); 

  rect(H1N1ButtonX, H1N1ButtonY, H1N1ButtonW, H1N1ButtonH);

  fill(255);
  text("H1N1", H1N1ButtonX +4, H1N1ButtonY + 12);

  if (selDisease == H5N1) fill(237, 50, 50);
  else fill(59, 73, 88);
  rect(H1N1ButtonX-40, H1N1ButtonY, H1N1ButtonW, H1N1ButtonH);

  fill(255);
  text("H5N1", H1N1ButtonX - 40 +4, H1N1ButtonY + 12);  

  if (selDisease == SARS) fill(237, 50, 50);
  else fill(59, 73, 88);
  rect(H1N1ButtonX-80, H1N1ButtonY, H1N1ButtonW, H1N1ButtonH);

  fill(255);
  text("SARS", H1N1ButtonX - 80 + 4, H1N1ButtonY + 12);  
}






