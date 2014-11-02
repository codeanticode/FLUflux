

void drawTimeSeries()
{
  noStroke();  
  fill(255);            
  rect(tseriesX, tseriesY, tseriesWidth, tseriesHeight);


  float w = float(tseriesWidth) / NUM_MONTHS;

  if (-1 < selRoute)
  {
    FlightRouteRecord route = (FlightRouteRecord)routesDB.routes.get(selRoute);

    fill(55, 105, 255);
    for (int i = 0; i < NUM_MONTHS; i++)
    {
      float h = tseriesBarHeight * (route.data01[i] / route.ave01);
      rect(i * w, tseriesY + 0.5 * tseriesHeight-20- h, w, h);
    }

    fill(15, 105, 150);
    for (int i = 0; i < NUM_MONTHS; i++)
    {
      float h = tseriesBarHeight * (route.data10[i] / route.ave10);
      rect(i * w, tseriesY + 0.5 * tseriesHeight, w, h);
    }

    if (-1 < selCountry)
    { 
      CountryDiseaseRecord disease = (CountryDiseaseRecord)diseaseDB.diseases[selDisease].get(selCountry);
      for (int i = 0; i < NUM_MONTHS; i++)
      {          
        float t = disease.data[i] / disease.ave;

        float r = 255;
        float g = (1 - t) * 255;
        float b = (1 - t) * 255;

        fill(r, g, b);
        rect(i * w, tseriesY + 0.5 * tseriesHeight - 20, w, 20);
      }
    }

    /*
    if (-1 < selBlogs)
     { 
     strokeWeight(1);
     CountryBlogsRecord blogs = (CountryBlogsRecord)diseaseDB.blogs[selDisease].get(selBlogs);
     float x, x0;
     float y, y0;
     x0 = 0;
     y0 = tseriesY + 0.5 * tseriesHeight + 10;
     for (int i = 0; i < NUM_MONTHS; i++)
     {          
     x = i * w;
     y = tseriesY + 0.5 * tseriesHeight - 10 - 5 * blogs.data[i] / blogs.ave;
     
     stroke(50, 50, 200);
     line(x0, y0, x, y);
     
     x0 = x;
     y0 = y;
     }
     }
     
     if (-1 < selNews)
     { 
     strokeWeight(1);      
     CountryNewsRecord news = (CountryNewsRecord)diseaseDB.news[selDisease].get(selNews);
     float x, x0;
     float y, y0;
     x0 = 0;      
     y0 = tseriesY + 0.5 * tseriesHeight - 10;
     for (int i = 0; i < NUM_MONTHS; i++)
     {
     x = i * w;
     y = tseriesY + 0.5 * tseriesHeight - 10 - 5 * news.data[i] / news.ave;
     
     stroke(50, 200, 50);
     line(x0, y0, x, y);
     
     x0 = x;
     y0 = y;
     }
     }
     */


    if (-1 < selBlogs && -1 < selNews)
    { 
      CountryBlogsRecord blogs = (CountryBlogsRecord)diseaseDB.blogs[selDisease].get(selBlogs);
      CountryNewsRecord news = (CountryNewsRecord)diseaseDB.news[selDisease].get(selNews);      
      for (int i = 0; i < NUM_MONTHS; i++)
      {
        float hb = 5 * blogs.data[i] / blogs.ave;
        float hn = 5 * news.data[i] / news.ave;

        float diff = hb - hn;

        //noStroke();          
        if (0 < diff)
        {
          fill(100,74,200);
          rect(i * w, tseriesY + 0.5 * tseriesHeight-20- hb, w, diff); //blogs
        }
        else 
        {
          fill(50, 200, 50);
          rect(i * w, tseriesY + 0.5 * tseriesHeight-20- hn, w, -diff); //news             
        }
      }      
    }    



    textFont(nfont, 8);
    fill(100);
    text("Click | Drag to Move in Time", 30, tseriesY + 145); 

    text(route.data01[int(time)], timeSliderX+7, 520);
    text(route.data10[int(time)], timeSliderX+7, 660);

    fill(150, 100);
    rect(timeSliderX, tseriesY + 60, w, tseriesHeight/2);   //here is the time bar   
    fill(0);
    rect(timeSliderX, tseriesY+130, w, 20);    
  }
  else
  {

    fill(150, 100);
    rect(timeSliderX, tseriesY + 60, w, tseriesHeight/2);   //here is the time bar   
    fill(50);
    rect(timeSliderX, tseriesY+130, w, 20);        
  }
  textFont(font, 11);
  fill(0);
  String s = currentYear + " " + monthNames[currentMonth];
  text(s, timeSliderX +7, 595);
}




