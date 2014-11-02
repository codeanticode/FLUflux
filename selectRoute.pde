
void selectRoute()
{
  FlightRouteRecord route;  
  for (int i = 0; i < routesDB.routes.size(); i++)
  {
    route = (FlightRouteRecord)routesDB.routes.get(i);
    if (!route.active) continue;

    int t = min(LAST_MONTH_INDEX - 1, int(time)); 
    float r = 20*(route.data10[t] / route.ave01);
    if (dist(mouseX, mouseY, route.x1, route.y1) < r)
    {
      println("Selected " + route.country);
      selRoute = i;

      selCountry = diseaseDB.getDiseaseIndex(selDisease, route.country);
      println(selCountry);

      selBlogs = diseaseDB.getBlogsIndex(selDisease, route.country);
      println(selBlogs);

      selNews = diseaseDB.getNewsIndex(selDisease, route.country);
      println(selNews);

      break;
    }    


    if (sphereIntersect(mouseX, mouseY, 5, route.x0, route.y0, route.x1, route.y1))
    {
      println("Selected " + route.country);
      selRoute = i;

      selCountry = diseaseDB.getDiseaseIndex(selDisease, route.country);
      println(selCountry);

      selBlogs = diseaseDB.getBlogsIndex(selDisease, route.country);
      println(selBlogs);

      selNews = diseaseDB.getNewsIndex(selDisease, route.country);
      println(selNews);

      break;
    }
  }
}



