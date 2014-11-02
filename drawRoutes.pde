
void drawRoutes()
{
  fill(255);
  noStroke();
  rect(mapX, mapY, mapWidth, mapHeight);

  float r0, r1, f;
  float currR, currG, currB;
  int idx;
  int t = min(LAST_MONTH_INDEX - 1, int(time)); 

  FlightRouteRecord route;
  for (int i = 0; i < routesDB.routes.size(); i++)
  {
    route = (FlightRouteRecord)routesDB.routes.get(i);
    if (!route.active) continue;

    route.setPosition(t);

    if (i == selRoute)
    {
      currR = 55;
      currG = 105;
      currB = 255;
      fill(currR, currG, currB);
      stroke(currR, currG, currB);
      strokeWeight(2*(route.data01[t] / route.ave01));       
      stroke(75);      
    }
    else
    {
      currR = 120;
      currG = 120;
      currB = 120;      
      fill(currR, currG, currB);
      stroke(currR, currG, currB);
      strokeWeight(2*(route.data01[t] / route.ave01)); 
      stroke(75);      
    }
    line(route.x0, route.y0, route.x1, route.y1);

    // US disease data.
    idx = diseaseDB.getDiseaseIndex(selDisease, "United States of America");
    if (-1 < idx)
    {
      CountryDiseaseRecord disease = (CountryDiseaseRecord)diseaseDB.diseases[selDisease].get(idx);
      f = disease.data[t] / disease.ave;
      r0 = MIN_COUNTRY_CIRCLE_RAD + f * MAX_COUNTRY_CIRCLE_RAD;

      float r = f * 255 + (1 - f) * currR;
      float g = 0 + (1 - f) * currG;
      float b = 0 + (1 - f) * currB;

      fill(r, g, b);
    }
    else r0 = MIN_COUNTRY_CIRCLE_RAD;    
    ellipse(route.x0, route.y0, r0, r0);

    // Country disease data
    idx = diseaseDB.getDiseaseIndex(selDisease, route.country);
    if (-1 < idx)
    {
      CountryDiseaseRecord disease = (CountryDiseaseRecord)diseaseDB.diseases[selDisease].get(idx);
      f = disease.data[t] / disease.ave;
      r1 = MIN_COUNTRY_CIRCLE_RAD + f * MAX_COUNTRY_CIRCLE_RAD;

      float r = f * 255 + (1 - f) * currR;
      float g = 0 + (1 - f) * currG;
      float b = 0 + (1 - f) * currB;

      fill(r, g, b);
    }
    else r1 = MIN_COUNTRY_CIRCLE_RAD;    

    //float r1 = 20*(route.data10[t] / route.ave01);
    ellipse(route.x1, route.y1, r1, r1);
  } 


  for (int i = 0; i < routesDB.routes.size(); i++)
  {
    route = (FlightRouteRecord)routesDB.routes.get(i);
    if (!route.active) continue;

    r1 = 20*(route.data10[t] / route.ave01);

    fill(0);
    pushMatrix();
    if (route.angle < PI / 2 || 3 * PI/2 < route.angle) {
      translate(route.x1, route.y1);  
      rotate(route.angle);
      translate(r1, 3);
    }
    else 
    {
      translate(route.x1, route.y1);      
      rotate(route.angle + PI);
      translate(-textWidth(route.country) - r1, 3);
    }
    fill(70);
    textFont(nfont, 9);
    text(route.country, 0, 0);
    popMatrix();
  }

  fill(15, 105, 150);
  stroke(15, 105, 150);
  ellipse(mapX + 0.5 * mapWidth, mapY + 0.5 * mapHeight, 10, 10);
}

