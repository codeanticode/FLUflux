
void selectDisease(int disease)
{
  if (selDisease != disease)
  {
    selDisease = disease;

    HashMap countryFilter = diseaseDB.countryFilters[selDisease];

    int nactive = 0;       
    FlightRouteRecord route;
    for (int i = 0; i < routesDB.routes.size(); i++)
    {
      route = (FlightRouteRecord)routesDB.routes.get(i);
      if (countryFilter.containsKey(route.country))
      {
        route.active = true;
        nactive++;
      }
      else route.active = false;
    }

    float angularStep = TWO_PI / nactive;
    int j = 0;
    for (int i = 0; i < routesDB.routes.size(); i++)
    {
      route = (FlightRouteRecord)routesDB.routes.get(i);
      if (route.active)
      {
        route.setAngle(angularStep * j);
        route.initPosition();
        route.setPosition(int(time));
        j++;
      }
    }

    selCountry = -1;
    selBlogs = -1;
    selNews = -1;        
  }
}

