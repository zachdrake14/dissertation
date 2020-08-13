from arcgis import GIS
import pandas as pd
from arcgis.features import GeoAccessor, GeoSeriesAccessor
from arcgis.geocoding import batch_geocode
from arcgis.features import SpatialDataFrame

gis = GIS('https://siarcgisweb01.trssllc.com/portal/home', 'sazdrake')

map1 = gis.map('New York, NY')
map1.basemap = "osm"
map1

address_frame = pd.read_csv('data/city_of_new_york.csv')

address_shp = SpatialDataFrame.from_xy(address_frame, 'LON', 'LAT')

address_shp.spatial.plot(map_widget = map1)