# Open Source Routing Machine with New Zealand OpenStreetMap

A simple Docker container with an [Open Source Routing Machine](http://project-osrm.org/) backend and basic [front-end](https://github.com/Project-OSRM/osrm-frontend), pre-populated with New Zealand OpenStreetMap data from [Geofabrik](http://download.geofabrik.de).

To get things up and running, open a shell and execute:

```bash
docker-compose up -d
```

The service will be running at `http://localhost:5001`, and the UI at `http://localhost:9966`.  It's relatively easy to get nice URLs via NGINX by adding location directives as follows (you'll need to update the `OSRM_BACKEND` environment variable in `docker-compose.yml` to `https://<host>/osrm/` or similar):

```plaintext
server {

  ...

  location /osrm/ {
    proxy_pass http://127.0.0.1:5001/;
  }

  location /osrm-frontend/ {
    proxy_pass http://127.0.0.1:9966/;
  }

  ...

}
```