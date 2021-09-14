  
 CREATE TABLE stars(
      name VARCHAR(100) PRIMARY KEY, 
      star_temp_k INT NOT NULL
  );

INSERT INTO stars(name, star_temp_k)
VALUES('The Sun', 5800), ('Proxima Centauri', 3042), ('Gliese 876', 3192);

 CREATE TABLE planets(
      name VARCHAR(100) PRIMARY KEY,
      orbit_star VARCHAR(100) NOT NULL REFERENCES stars,
      orbital_period_yrs FLOAT NOT NULL 
  ); 
INSERT INTO planets(name, orbit_star, orbital_period_yrs)
VALUES('Earth','The Sun', 1.00), ('Mars','The Sun',1.882), 
('Venus', 'The Sun', 0.62), ('Proxima Centauri b','Proxima Centauri', 0.3),
('Gliese 876 b','Gliese 876', 0.236);

  CREATE TABLE moons(
      name VARCHAR(100) PRIMARY KEY,
      orbit_planet VARCHAR(100) NOT NULL REFERENCES planets
  );

INSERT INTO moons(name, orbit_planet)
VALUES('The Moon', 'Earth'), ('Phobos', 'Mars'), ('Deimos', 'Mars');


SELECT p.name, s.name, COUNT(m)
FROM planets as p
LEFT JOIN stars as s
ON p.orbit_star = s.name
LEFT JOIN moons as m
ON m.orbit_planet = p.name
GROUP BY p.name, s.name
ORDER BY p.name;

SELECT planets.name, stars.name, COUNT(moons)
FROM moons
RIGHT JOIN planets
ON moons.orbit_planet = planets.name
RIGHT JOIN stars
ON planets.orbit_star = stars.name
GROUP BY planets.name, stars.name
ORDER BY planets.name;

SELECT planets.name, stars.name, COUNT(moons)
FROM moons
RIGHT JOIN planets
ON moons.orbit_planet = planets.name
JOIN stars
ON planets.orbit_star = stars.name
GROUP BY planets.name, stars.name
ORDER BY planets.name;