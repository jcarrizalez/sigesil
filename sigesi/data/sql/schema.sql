CREATE TABLE si_centro_acopio (id BIGINT, nombre CHAR(255) NOT NULL, rif CHAR(255) NOT NULL, telefono CHAR(255), email CHAR(255), ubicacion CHAR(255), coordenadas CHAR(255), id_sap CHAR(255), id_organizacion CHAR(255), PRIMARY KEY(id));
CREATE TABLE si_silos (id BIGINT, id_centro_acopio BIGINT NOT NULL, nombre CHAR(255) NOT NULL, ubicacion CHAR(3), PRIMARY KEY(id));
CREATE SEQUENCE centro_acopio_seq INCREMENT 1 START 1;
CREATE SEQUENCE silos_seq INCREMENT 1 START 1;
ALTER TABLE si_silos ADD CONSTRAINT si_silos_id_centro_acopio_si_centro_acopio_id FOREIGN KEY (id_centro_acopio) REFERENCES si_centro_acopio(id) NOT DEFERRABLE INITIALLY IMMEDIATE;
