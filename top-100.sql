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
SELECT COUNT(id) AS Q_peliculas FROM peliculas;
SELECT COUNT(reparto) AS Q_reparto FROM reparto;
-- 3. Obtener el ID de la película “Titanic”. (1 Punto)
SELECT id AS idTitanic FROM peliculas WHERE Pelicula = 'Titanic';
-- 4. Listar a todos los actores que aparecen en la película "Titanic". (1 Puntos)
-- 4a.- Con consulta directa en reparto por número de id
SELECT reparto FROM reparto WHERE peliculaId = 2;
-- 4b.- Con relación de tablas (Join) y a través de la tabla películas 
SELECT r.reparto FROM peliculas AS p JOIN reparto AS r ON p.id = r.peliculaId WHERE p.pelicula = 'Titanic';
-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford. (2 Puntos)
SELECT COUNT(peliculaId) AS HarrisonFord FROM reparto WHERE reparto = 'Harrison Ford';
-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de
-- manera ascendente. (1 punto)
SELECT Pelicula FROM peliculas WHERE AgnoEstreno BETWEEN 1990 AND 1999 ORDER BY pelicula ASC;
-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser
-- nombrado para la consulta como “longitud_titulo”. (1 punto)
SELECT pelicula, LENGTH(pelicula) AS longitud_titulo FROM peliculas;
-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
-- (2 punto)
-- 8a.- Consulta con limite de registros 
SELECT LENGTH(pelicula) AS longitud_titulo FROM peliculas ORDER BY LENGTH(pelicula) DESC LIMIT 1;
-- 8b.- Consulta con query anidada 
SELECT LENGTH(pelicula) AS longitud_titulo FROM peliculas WHERE
LENGTH(pelicula) = (SELECT MAX(LENGTH(pelicula)) FROM peliculas);