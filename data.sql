/* Populate database with sample data. */
-- DAY 1 - Create animals table.
INSERT INTO animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES ('Agumon', '2020-02-3', 0, B '1', 10.23),
  ('Gabumon', '2018-11-15', 2, B '1', 8.0),
  ('Pikachu', '2021-01-07', 1, B '0', 15.04),
  ('Devimon', '2017-05-12', 5, B '1', 11.0);
-- DAY 2 - Query and Update animals table.
INSERT INTO animals (
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
  )
VALUES ('Charmander', '2020-02-08', -11, B '0', 0),
  ('Plantmon', '2021-11-15', -5.7, B '1', 2),
  ('Squirtle', '1993-04-02', -12.13, B '0', 3),
  ('Angemon', '2005-06-12', -45, B '1', 1),
  ('Boarmon', '2005-06-07', 20.4, B '1', 7),
  ('Blossom', '1998-10-13', 17, B '1', 3),
  ('Ditto', '2022-05-14', 22, B '1', 4);
-- Update the animals table by setting the species column to unspecified.
-- Verify that change was made. Then roll back the change
-- Verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals
SET species = 'unspecified';
TABLE animals;
ROLLBACK;
TABLE animals;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
TABLE animals;
COMMIT;
-- Delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
TABLE animals;
ROLLBACK;
TABLE animals;
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
TABLE animals;
COMMIT;
-- DAY 3
BEGIN;
INSERT INTO OWNERS(full_name, age)
VALUES ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody POnd', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);
TABLE owners;
COMMIT;
BEGIN;
INSERT INTO SPECIES(name)
VALUES ('Pokemon'),
  ('Digimon');
TABLE species;
COMMIT;
-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
UPDATE animals
SET species_id = (
    SELECT id
    FROM species
    WHERE name = 'Digimon'
  )
WHERE name LIKE '%mon';
-- All other animals are Pokemon
UPDATE animals
SET species_id = (
    SELECT id
    FROM species
    WHERE name = 'Pokemon'
  )
WHERE species_id IS NULL;
-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
BEGIN;
UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Sam Smith'
  )
WHERE name = 'Agumon';
TABLE animals;
COMMIT;
-- Jennifer Orwell owns Gabumon and Pikachu.
BEGIN;
UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Jennifer Orwell'
  )
WHERE name = 'Gabumon'
  OR name = 'Pikachu';
TABLE animals;
COMMIT;
-- Bob owns Devimon and Plantmon.
BEGIN;
UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Bob'
  )
WHERE name = 'Devimon'
  OR name = 'Plantmon';
TABLE animals;
COMMIT;
-- Melody Pond owns Charmander, Squirtle, and Blossom.
BEGIN;
UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Melody POnd'
  )
WHERE name = 'Charmander'
  OR name = 'Squirtle'
  OR name = 'Blossom';
TABLE animals;
COMMIT;
-- Dean Winchester owns Angemon and Boarmon.
BEGIN;
UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Dean Winchester'
  )
WHERE name = 'Angemon'
  OR name = 'Boarmon';
TABLE animals;
COMMIT;
-- DAY 4
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');
INSERT INTO specialization (vet_id, species_id)
VALUES (1, 1),
  (3, 1),
  (3, 2),
  (4, 2);
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES (1, 1, '2020-05-24'),
  (3, 1, '2020-07-22'),
  (4, 2, '2021-02-02'),
  (2, 3, '2020-01-05'),
  (2, 3, '2020-03-08'),
  (2, 3, '2020-05-14'),
  (3, 5, '2021-02-24'),
  (2, 6, '2019-12-21'),
  (1, 6, '2020-08-10'),
  (2, 6, '2021-04-07'),
  (3, 7, '2019-09-29'),
  (4, 8, '2020-10-03'),
  (4, 8, '2020-11-04'),
  (2, 9, '2019-01-24'),
  (2, 9, '2019-05-15'),
  (2, 9, '2020-02-27'),
  (2, 9, '2020-08-03'),
  (3, 10, '2020-05-24'),
  (1, 10, '2021-01-11');