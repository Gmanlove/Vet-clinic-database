/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempt, neutered, weight_kg, species) VALUES
('Agumon', '2020-02-03', 0, true, 10.23, NULL),
('Gabumon', '2018-11-15', 2, true, 8, NULL),
('Pikachu', '2021-01-07', 1, false, 15.04, NULL),
('Devimon', '2017-05-12', 5, true, 11, NULL),
('Charmander', '2020-02-08', 0, false, -11, NULL),
('Plantmon', '2021-11-15', 2, true, -5.7, NULL),
('Squirtle', '1993-04-02', 3, false, -12.13, NULL),
('Angemon', '2005-06-12', 1, true, -45, NULL),
('Boarmon', '2005-06-07', 7, true, 20.4, NULL),
('Blossom', '1998-10-13', 3, true, 17, NULL),
('Ditto', '2022-05-14', 4, true, 22, NULL);


INSERT INTO owners (full_name,age) VALUES ('Sam Smith',34);
INSERT INTO owners (full_name,age) VALUES ('Jennifer Orwell',19);
INSERT INTO owners (full_name,age) VALUES ('Bob',45);
INSERT INTO owners (full_name,age) VALUES ('Melody Pond',77);
INSERT INTO owners (full_name,age) VALUES ('Dean Winchester',14);
INSERT INTO owners (full_name,age) VALUES ('Jodie Whittake',38);

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');


BEGIN WORK;
update animals SET species_id = 1 WHERE name NOT LIKE '%mon'; 
update animals SET species_id = 2 WHERE name LIKE '%mon';
COMMIT WORK;

BEGIN WORK;
update animals SET owner_id = owners.id 
FROM owners 
WHERE animals.name='Agumon' AND owners.full_name='Sam Smith';

update animals SET owner_id = owners.id 
FROM owners 
WHERE (owners.full_name='Jennifer Orwell') AND (animals.name='Gabumon' OR animals.name='Pikachu');

update animals SET owner_id = owners.id 
FROM owners 
WHERE (owners.full_name='Bob') AND (animals.name='Devimon' OR animals.name='Plantmon');

update animals SET owner_id = owners.id 
FROM owners 
WHERE (owners.full_name='Melody Pond') 
AND (animals.name='Charmander' OR animals.name='Squirtle' OR animals.name='Blossom');

update animals SET owner_id = owners.id 
FROM owners 
WHERE (owners.full_name='Dean Winchester') AND (animals.name='Angemon' OR animals.name='Boarmon');

COMMIT WORK;