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