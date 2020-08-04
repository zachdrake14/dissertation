import geopandas
import pandas

shp = geopandas.read_file('data/nyc_parcel/DTM_Tax_Lot_Polygon.shp')
shp.info()
