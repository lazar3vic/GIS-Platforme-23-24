-- load_data.sql
-- Kreira primer tabele graniceAmazona i dodatne kolone
CREATE EXTENSION IF NOT EXISTS postgis;

DROP TABLE IF EXISTS graniceAmazona;
CREATE TABLE graniceAmazona (
  id serial primary key,
  name text,
  area_km2 double precision,
  geom geometry(MultiPolygon, 4326)
);

-- Primer ulaza (jednostavni poligoni kao WKT) - samo demo podaci
INSERT INTO graniceAmazona (name, area_km2, geom) VALUES
('Blok A', 1200.5, ST_Multi(ST_GeomFromText('POLYGON((-60 0,-59 0,-59 1,-60 1,-60 0))',4326))),
('Blok B', 50.25, ST_Multi(ST_GeomFromText('POLYGON((-58 0,-57 0,-57 0.5,-58 0.5,-58 0))',4326))),
('Blok C', 8000, ST_Multi(ST_GeomFromText('POLYGON((-62 -1,-60 -1,-60 1,-62 1,-62 -1))',4326)));
