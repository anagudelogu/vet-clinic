/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id INT,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BIT,
    weight_kg FLOAT,
    PRIMARY KEY (id)
);
-- DAY 2
ALTER TABLE animals
ADD species VARCHAR(50);
-- DAY 3
-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
CREATE TABLE owners(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(255),
    age INT
);
-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
CREATE TABLE species(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255)
);
-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
ALTER TABLE ANIMALS DROP COLUMN SPECIES;
-- Add column species_id which is a foreign key referencing species table
ALTER TABLE ANIMALS
ADD species_id INT;
ALTER TABLE ANIMALS
ADD CONSTRAINT species_id FOREIGN KEY (species_id) REFERENCES species (id);
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE ANIMALS
ADD owner_id INT;
ALTER TABLE ANIMALS
ADD CONSTRAINT owner_id FOREIGN KEY (owner_id) REFERENCES owners (id);
-- DAY 4
-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
CREATE TABLE vets (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    age INT,
    date_of_graduation date
);
-- There is a many-to-many relationship between the tables species and vets:
-- A vet can specialize in multiple species.
-- Species can have multiple vets specialized in it.
-- Create a "join table" called specializations to handle this relationship.
CREATE TABLE specialization (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT FK_vets FOREIGN KEY (vet_id) REFERENCES vets (id),
    CONSTRAINT FK_species FOREIGN KEY (species_id) REFERENCES species (id)
);
-- There is a many-to-many relationship between the tables animals and vets:
-- An animal can visit multiple vets.
-- One vet can be visited by multiple animals.
-- Create a "join table" called visits to handle this relationship.
-- It should also keep track of the date of the visit.
CREATE TABLE visits (
    vet_id INT,
    animal_id INT,
    date_of_visit date,
    PRIMARY KEY (vet_id, animal_id),
    CONSTRAINT FK_vets FOREIGN KEY (vet_id) REFERENCES vets (id),
    CONSTRAINT FK_animals FOREIGN KEY (animal_id) REFERENCES animals (id)
);