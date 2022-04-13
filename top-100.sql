-- Descripción
-- Se requiere crear un sitio web dedicado al mundo cinematográfico donde los usuarios
-- puedan buscar detalles del top 100 de películas más populares. El plus más importante de
-- este sitio web debe ser la variedad de filtros que ofrece para una búsqueda más efectiva.
-- Para este desafío necesitarás crear 2 tablas llamadas películas y reparto, sus datos los
-- consigues en los ficheros de extensión csv ubicados en el Apoyo Desafío.
-- Requerimientos
-- 1. Crear una base de datos llamada películas. (1 Punto)
\c ftobarv
DROP DATABASE peliculas;
CREATE DATABASE peliculas;
\c peliculas
-- 2. Cargar ambos archivos a su tabla correspondiente. (1 Punto)
-- 2a.- Creamos tabla peliculas y cargamos los datos del csv
CREATE TABLE peliculas(
    id SERIAL,
    pelicula VARCHAR(70),
    agnoEstreno SMALLINT,
    director VARCHAR(30),
    PRIMARY KEY (id)
);
\copy peliculas FROM 'peliculas.csv' csv header;
-- 2b.- Creamos tabla reparto y cargamos los datos del csv
CREATE TABLE reparto(
    peliculaId INT,
    reparto VARCHAR(40),
    FOREIGN KEY (peliculaId) REFERENCES peliculas(id)
);
\copy reparto FROM 'reparto.csv' csv;
-- Revisamos la carga de los datos. Para ello, contamos los registros en cada tabla
SELECT COUNT(id) AS NroPeliculas FROM peliculas;
SELECT COUNT(reparto) AS CantActores FROM reparto;
