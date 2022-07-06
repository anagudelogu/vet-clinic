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
ALTER TABLE animals
ADD species VARCHAR(50);