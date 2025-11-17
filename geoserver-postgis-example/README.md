# GeoServer + PostGIS example (prepared project)

    Sadržaj ovog paketa pokazuje kako postaviti GeoServer + PostGIS i klijent (OpenLayers) koji prikazuje:

- Raster WMS: `myworkspace:myExportImageTask2022`
- Vektor WMS: `myworkspace:graniceAmazona`
- Parametrizovani SQL-view sloj: `myworkspace:amazonia_filtered` (primer)

## Struktura

```
geoserver-postgis-example/
├─ docker-compose.yml
├─ sql/load_data.sql
├─ html/map.html
├─ README.md
```

## Koraci za pokretanje (lokalno)

1. Pokreni Docker Compose:

```bash
docker compose up -d
```

2. Uvezi primer SQL podataka u PostGIS (primer iz `sql/load_data.sql`):

```bash
docker cp sql/load_data.sql postgis:/load_data.sql
docker exec -it postgis bash -c "psql -U gisuser -d gisdb -f /load_data.sql"
```

3. Prijavi se u GeoServer UI: `http://localhost:8080/geoserver` (admin / lozinka koju si podesio u docker-compose)

4. Dodaj PostGIS store u GeoServer (host: `postgis`, db: `gisdb`, user: `gisuser`, password: `gispass`).
   - Nakon što povežeš store, publikuje tabelu `graniceAmazona` kao layer `graniceAmazona`.

5. Dodaj raster (GeoTIFF) kao store ili upload — nazovi layer `myExportImageTask2022` u workspace `myworkspace`.

6. **SQL view** `amazonia_filtered` — definiši novi SQL view u GeoServer-u (prilikom publish-a PostGIS store) koristeći SQL:

```sql
SELECT id, name, area_km2, geom FROM graniceAmazona WHERE area_km2 >= %min_area%
```

Dodaj parametar `min_area` tipa `double` sa podrazumevanom vrednošću `0`.

7. Otvori `html/map.html` u browseru (možeš servirati fajl statički ili otvoriti direktno) i testiraj unos `Minimalna površina` -> `Apply`.

## Git

Ako želiš da pošalješ na GitHub:

```bash
git init
git add .
git commit -m "Initial commit: GeoServer + PostGIS example"
# dodaj remote i push
git remote add origin https://github.com/USERNAME/geoserver-postgis-example.git
git branch -M main
git push -u origin main
```

---

*Ovaj paket je demo i treba biti prilagođen za produkciju (lozinke, mreža, pristup).*
