
// Returns true if the line between (x0, y0) and (x1, y1) intersects with the sphere of radius 
// r centered at (sX, sY).

boolean sphereIntersect(float sX, float sY, float r, float x0, float y0, float x1, float y1)
{
  float tx = x0 - sX;
  float ty = y0 - sY;  
  float dx = x1 - x0;
  float dy = y1 - y0;

  float a = sq(dx) + sq(dy);
  float b = 2 * (tx * dx + ty * dy);
  float c = sq(tx) + sq(ty) - sq(r);
  float det = sq(b) - 4 * a * c;

  if (det < 0) return false;

  float t0 = (-b + sqrt(det)) / (2 * a);
  float t1 = (-b - sqrt(det)) / (2 * a);

  return (0 <= t0 && t0 <= 1) || (0 <= t1 && t1 <= 1);
}




boolean insideMap()
{
  return mapX <= mouseX && mouseX < mapX + mapWidth && mapY <= mouseY && mouseY < mapY + mapHeight;
}


boolean insideTSeries()
{
  return tseriesX <= mouseX && mouseX < tseriesX + tseriesWidth && tseriesY <= mouseY && mouseY < tseriesY + tseriesHeight;
}

boolean insideH1N1Button()
{
  return H1N1ButtonX < mouseX && mouseX <= H1N1ButtonX + H1N1ButtonW && H1N1ButtonY <= mouseY && mouseY <= H1N1ButtonY + H1N1ButtonH;
}

boolean insideH5N1Button()
{
  return H1N1ButtonX -40 < mouseX && mouseX <= H1N1ButtonX + H1N1ButtonW && H1N1ButtonY <= mouseY && mouseY <=  H1N1ButtonY + H1N1ButtonH;
}

boolean insideSARSButton()
{
  return H1N1ButtonX -80 < mouseX && mouseX <= H1N1ButtonX + H1N1ButtonW && H1N1ButtonY  <= mouseY && mouseY <= H1N1ButtonY+ H1N1ButtonW +  H1N1ButtonH;
}


