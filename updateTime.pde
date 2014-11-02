
void updateTime()
{
  if (playing && time < NUM_MONTHS) time += timeInc;  

  int count = int(time);
  int y = int(count / 12);
  currentMonth = count - 12 * y;
  currentYear = (y + FIRST_YEAR);  

  timeSliderX = map(time, 0, NUM_MONTHS, tseriesX, tseriesWidth);   

  if (NUM_MONTHS <= time) 
  {
    time = 0.0;
  }
}
