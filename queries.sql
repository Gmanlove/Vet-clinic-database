/*Queries that provide answers to the questions from all projects.*/

--Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

--List the name of all animals born between 2016 and 2019.
SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

--List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals
WHERE neutered = true AND escape_attempt < 3;

--List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals
WHERE name IN ('Agumon', 'Pikachu');


--List name and escape attempts of animals that weigh more than 10.5kg.
SELECT name, escape_attempt FROM animals
WHERE weight_kg > 10.5;


--Find all animals that are neutered.
SELECT * FROM animals
WHERE neutered = true;

--Find all animals not named Gabumon
SELECT * FROM animals
WHERE name != 'Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;



BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Commit the transaction. */

BEGIN WORK; 
update animals SET species = 'digimon' WHERE name LIKE '%mon';
update animals SET species = 'pokemon' WHERE species is null;
SELECT * from animals;
COMMIT WORK;

-- delete All records Then Rollback and check
BEGIN WORK; 
DELETE FROM animals;
SELECT * from animals;
ROLLBACK WORK;
SELECT * from animals;

/* specific delete and update transaction */
-- begin transaction
BEGIN WORK; 
-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022,01,01'::date;
-- Create a savepoint for the transaction
SAVEPOINT SAVE_01; 
-- Update all animals' weight to be their weight multiplied by -1
update animals SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO SAVE_01;
-- Update all animals' weights that are negative to be their weight multiplied by -1
update animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Commit transaction;
COMMIT WORK;


SELECT * FROM animals JOIN owners ON owners.id = animals.owner_id AND owners.full_name='Melody Pond'; 

-- List of all animals that are pokemon (their type is Pokemon)
SELECT * FROM animals JOIN species ON species.id = animals.species_id AND species.name='Pokemon';



SELECT full_name , name From owners Left JOIN animals ON animals.owner_id=owners.id;


-- How many animals are there per species?
SELECT species.name , COUNT(animals.name) AS Animals_Number 
From species 
JOIN animals ON species.id=animals.species_id
GROUP BY species.name; 


-- List all Digimon owned by Jennifer Orwell
SELECT animals.name, owners.full_name 
from animals 
JOIN owners 
ON (animals.owner_id=owners.id AND owners.full_name = 'Jennifer Orwell')
JOIN species
ON (animals.species_id=species.id AND species.name='Digimon'); 


-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT owners.full_name, animals.name
FROM owners
JOIN animals
ON animals.owner_id=owners.id AND animals.escape_attempt = 0
WHERE owners.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT owners.full_name , COUNT(animals.name) AS Animals_Number
From owners
JOIN animals ON owners.id=animals.owner_id
GROUP BY owners.full_name
ORDER BY Animals_Number DESC; 