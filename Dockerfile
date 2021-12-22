FROM osrm/osrm-backend

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates wget && \
  mkdir /data && \
  cd /data && \
  wget http://download.geofabrik.de/australia-oceania/new-zealand-latest.osm.pbf && \
  wget https://raw.githubusercontent.com/Project-OSRM/osrm-backend/master/data/driving_side.geojson && \
  osrm-extract -p /opt/car.lua --location-dependent-data /data/driving_side.geojson /data/new-zealand-latest.osm.pbf && \
  osrm-partition /data/new-zealand-latest.osrm && \
  osrm-customize /data/new-zealand-latest.osrm && \
  rm new-zealand-latest.osm.pbf

EXPOSE 5000

CMD ["osrm-routed", "--max-trip-size", "1600", "--max-viaroute-size", "1600", "--algorithm", "mld", "/data/new-zealand-latest.osrm"]
