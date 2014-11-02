String monthNames[] = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };

String diseaseNames[] = { "H1N1", "H5N1", "SARS" };

int H1N1 = 0;
int H5N1 = 1;
int SARS = 2;

class CountryNewsRecord
{

  CountryNewsRecord(String _disease, String _newsString, int _startYear, int _endYear)
    {
        String parts[] = _newsString.split(",");
        
        disease = _disease;
        country = parts[0];
        
        data = new float[NUM_MONTHS];
        
        int n0 = (_startYear - 1990) * 12;
        int n1 = (_endYear - 1990 + 1) * 12;
        
        ave = 0;
        int ntot = 0;
        for (int i = 0; i < n1 - n0 + 1; i++)
        {
            data[n0 + i - 1] = parseFloat(parts[i]);
            if (0 < data[n0 + i - 1]) 
            {
                ave += data[n0 + i - 1];
                ntot++;
            }
        }
        ave /= ntot;
    }  

    String country;
    String disease;
    float ave;
    float data[];

}



class CountryBlogsRecord
{
    CountryBlogsRecord(String _disease, String _blogsString, int _startYear, int _endYear)
    {
        String parts[] = _blogsString.split(",");
        
        disease = _disease;
        country = parts[0];
        
        data = new float[NUM_MONTHS];
        
        int n0 = (_startYear - 1990) * 12;
        int n1 = (_endYear - 1990 + 1) * 12;
        
        ave = 0;
        int ntot = 0;
        for (int i = 0; i < n1 - n0 + 1; i++)
        {
            data[n0 + i - 1] = parseFloat(parts[i]);
            if (0 < data[n0 + i - 1]) 
            {
                ave += data[n0 + i - 1];
                ntot++;
            }
        }
        ave /= ntot;
    }  

    String country;
    String disease;
    float ave;
    float data[];
}


class CountryDiseaseRecord
{
    CountryDiseaseRecord(String _disease, String _diseaseString, int _startYear, int _endYear)
    {
        String parts[] = _diseaseString.split(",");
        
        disease = _disease;
        country = parts[0];
        
        data = new int[NUM_MONTHS];
        
        int n0 = (_startYear - 1990) * 12;
        int n1 = (_endYear - 1990 + 1) * 12;
        
        ave = 0;
        int ntot = 0;
        for (int i = 0; i < n1 - n0 + 1; i++)
        {
            data[n0 + i - 1] = parseInt(parts[i]);
            if (0 < data[n0 + i - 1]) 
            {
                ave += data[n0 + i - 1];
                ntot++;
            }
        }
        ave /= ntot;
    }  

    String country;
    String disease;
    float ave;
    int data[];
}


class FlightRouteRecord
{
    FlightRouteRecord(String _routeString)
    {        
        String parts[] = _routeString.split(",");
        
        country = parts[0];
        
        ave01 = parseFloat(parts[1]);
        data01 = new int[NUM_MONTHS];        
        for (int i = 0; i < NUM_MONTHS; i++)
        {
            data01[i] = parseInt(parts[2 + i]);
        }
        
        ave10 = parseFloat(parts[2 + NUM_MONTHS]);
        data10 = new int[NUM_MONTHS];        
        for (int i = 0; i < NUM_MONTHS; i++)
        {
            data10[i] = parseInt(parts[3 + NUM_MONTHS + i]);
        }
        
        active = false;
    }    

    void setAngle(float _angle)
    {
        angle = _angle;   
    }
    
    void initPosition()
    {
        x0 = mapX + 0.5 * mapWidth;   
        y0 = mapY + 0.5 * mapHeight;

        x1 = x0 + defRouteLength * cos(angle);
        y1 = y0 + defRouteLength * sin(angle);
    }
    
    void setPosition(int _monthIndex)
    {
        if (0 < ave10 && 0 < ave01)
        {
            float f = constrain(1 - (data01[_monthIndex] / ave01), 0.2, 1);

            x1 = x0 + f * defRouteLength * cos(angle);
            y1 = y0 + f * defRouteLength * sin(angle);
        }
        else
        {
            x1 = x0 + defRouteLength * cos(angle);
            y1 = y0 + defRouteLength * sin(angle);          
        }
    }

    String country;

    float ave01, ave10;
    int data01[];
    int data10[];
    
    float x0, y0;
    float x1, y1;
    float angle;
    
    boolean active;
}

class FlightRouteDatabase
{
    FlightRouteDatabase(String _dataFile)
    {
        String lines[] = loadStrings(_dataFile);         

        FlightRouteRecord route;
        routes = new ArrayList();
        for (int i = 0; i < lines.length; i++)
        {
            route = new FlightRouteRecord(lines[i]);            
            routes.add(route);
        }
        println("Loaded " + routes.size() + " routes.");
    }
 
    ArrayList routes;
}


class DiseaseDatabase
{
    DiseaseDatabase(String _dataFileH1N1, String _dataFileH5N1, String _dataFileSARS, 
                    String _newsFileH1N1, String _newsFileH5N1, String _newsFileSARS, 
                    String _blogsFileH1N1, String _blogsFileH5N1, String _blogsFileSARS)
    {
        CountryDiseaseRecord countryDisease;
        CountryBlogsRecord countryBlogs;
        CountryNewsRecord countryNews;
        
        String lines[];
        String parts[];
        String tmp[];
        String dataFiles[];
        int year0, year1;
 
        dataFiles = new String[3]; 
 
        diseases = new ArrayList[3];
        diseases[H1N1] = new ArrayList();
        diseases[H5N1] = new ArrayList();
        diseases[SARS] = new ArrayList();

        news = new ArrayList[3];
        news[H1N1] = new ArrayList();
        news[H5N1] = new ArrayList();
        news[SARS] = new ArrayList();
        
        blogs = new ArrayList[3];
        blogs[H1N1] = new ArrayList();
        blogs[H5N1] = new ArrayList();
        blogs[SARS] = new ArrayList();
        
        countryFilters = new HashMap[3];
        countryFilters[H1N1] = new HashMap();
        countryFilters[H5N1] = new HashMap();
        countryFilters[SARS] = new HashMap();
        
        dataFiles[H1N1] = _dataFileH1N1;
        dataFiles[H5N1] = _dataFileH5N1;
        dataFiles[SARS] = _dataFileSARS;        
        for (int d = H1N1; d <= SARS; d++) 
        {
            if (dataFiles[d].equals("")) continue;
            
            // Getting year interval for disease d.
            lines = loadStrings(dataFiles[d]);
            parts = lines[0].split(",");
            tmp = parts[1].split("-");
            year0 = parseInt(tmp[1]);
            tmp = parts[parts.length - 1].split("-");
            year1 = parseInt(tmp[1]);
        
            for (int i = 1; i < lines.length; i++) // The first line contains the field descriptions.
            {
                countryDisease = new CountryDiseaseRecord(diseaseNames[d], lines[i], year0, year1);
                diseases[d].add(countryDisease);
                countryFilters[d].put(countryDisease.country, i - 1);
            }
            println("Loaded " + diseaseNames[d] + " data for " + diseases[d].size() + " countries.");
        }

        dataFiles[H1N1] = _newsFileH1N1;
        dataFiles[H5N1] = _newsFileH5N1;
        dataFiles[SARS] = _newsFileSARS;        
        for (int d = H1N1; d <= SARS; d++) 
        {
            if (dataFiles[d].equals("")) continue;
            
            // Getting year interval for disease d.
            lines = loadStrings(dataFiles[d]);
            parts = lines[0].split(",");
            tmp = parts[1].split("-");
            year0 = parseInt(tmp[1]);
            tmp = parts[parts.length - 1].split("-");
            year1 = parseInt(tmp[1]);
        
            for (int i = 1; i < lines.length; i++) // The first line contains the field descriptions.
            {
                countryNews = new CountryNewsRecord(diseaseNames[d], lines[i], year0, year1);
                news[d].add(countryNews);
            }
            println("Loaded " + diseaseNames[d] + " news for " + news[d].size() + " countries.");
        }
        
        dataFiles[H1N1] = _blogsFileH1N1;
        dataFiles[H5N1] = _blogsFileH5N1;
        dataFiles[SARS] = _blogsFileSARS;        
        for (int d = H1N1; d <= SARS; d++) 
        {
            if (dataFiles[d].equals("")) continue;
            
            // Getting year interval for disease d.
            lines = loadStrings(dataFiles[d]);
            parts = lines[0].split(",");
            tmp = parts[1].split("-");
            year0 = parseInt(tmp[1]);
            tmp = parts[parts.length - 1].split("-");
            year1 = parseInt(tmp[1]);
        
            for (int i = 1; i < lines.length; i++) // The first line contains the field descriptions.
            {
                countryBlogs = new CountryBlogsRecord(diseaseNames[d], lines[i], year0, year1);
                blogs[d].add(countryBlogs);
            }
            println("Loaded " + diseaseNames[d] + " blogs for " + blogs[d].size() + " countries.");
        }
    }
    
    int getDiseaseIndex(int idx, String country)
    {
        CountryDiseaseRecord disease;
        for (int i = 0; i < diseases[idx].size(); i++)
        {
            disease = (CountryDiseaseRecord)diseases[idx].get(i);
            if (disease.country.equals(country)) return i;
        }
        return -1;
    }

    int getBlogsIndex(int idx, String country)
    {
        CountryBlogsRecord countryBlogs;
        for (int i = 0; i < news[idx].size(); i++)
        {
            countryBlogs = (CountryBlogsRecord)blogs[idx].get(i);
            if (countryBlogs.country.equals(country)) return i;
        }
        return -1;
    }

    int getNewsIndex(int idx, String country)
    {
        CountryNewsRecord countryNews;
        for (int i = 0; i < news[idx].size(); i++)
        {
            countryNews = (CountryNewsRecord)news[idx].get(i);
            if (countryNews.country.equals(country)) return i;
        }
        return -1;
    }
    
    ArrayList diseases[];
    ArrayList news[];
    ArrayList blogs[];    
    HashMap countryFilters[];
}
