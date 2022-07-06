/*Queries that provide answers to the questions from all projects.*/
-- Find all animals whose name ends in "mon".
SELECT *
FROM animals
WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name
FROM animals
WHERE neutered = B '1'
  AND escape_attempts < 3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth
FROM animals
WHERE name = 'Agumon'
  OR name = 'Pikachu';
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,
  escape_attempts
FROM animals
WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT *
FROM animals
WHERE neutered = B '1';
-- Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE NOT name = 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 and 17.3;
-- DAY 2
-- How many animals are there?
SELECT COUNT(*)
FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts)
FROM animals
WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT AVG(escape_attempts)
FROM animals
GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species,
  MIN(weight_kg) as MIN_WEIGHT,
  MAX(weight_kg) as MAX_WEIGHT
FROM animals
GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,
  AVG(escape_attempts) as Average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
-- DAY 3
-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT name as animal_name
FROM owners
  INNER JOIN animals ON owners.id = animals.owner_id
WHERE owners.id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Melody POnd'
  );
-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
FROM animals
  INNER JOIN species ON animals.species_id = species.id
WHERE species.id = (
    SELECT id
    FROM species
    WHERE name = 'Pokemon'
  );
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name as Owner,
  name as Animal
FROM owners
  LEFT JOIN animals ON owners.id = animals.owner_id;
-- How many animals are there per species?
SELECT species.name,
  COUNT(*) as quantity
FROM animals
  INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name as Digimon_Owned
FROM animals
  INNER JOIN species ON animals.species_id = species.id
WHERE species.id = (
    SELECT id
    FROM species
    WHERE name = 'Digimon'
  )
  AND animals.owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Jennifer Orwell'
  );
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name as animal
FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Dean Winchester'
  )
  AND animals.escape_attempts = 0;
-- Who owns the most animals?
-- Main method:
SELECT full_name as name,
  COUNT(full_name)
FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY full_name
HAVING COUNT(full_name) = (
    SELECT MAX(c)
    FROM (
        SELECT full_name,
          COUNT(full_name) as c
        FROM animals
          INNER JOIN owners ON animals.owner_id = owners.id
        GROUP BY full_name
      ) x
  );
-- Alternative method:
SELECT full_name as name,
  COUNT(full_name) count
FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY count DESC
LIMIT 1;