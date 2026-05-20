-- ========================================
-- PARTE 1: CREACION DE BASE DE DATOS
-- ========================================

CREATE DATABASE IF NOT EXISTS gestion_pet;
SHOW DATABASES;
USE gestion_pet;

-- ========================================
-- PARTE 2: CREACION DE TABLAS
-- ========================================

CREATE TABLE Estudiantes (
    id_estudiante INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_ingreso DATE NOT NULL,
    estado VARCHAR(15) DEFAULT 'Activo'
);

CREATE TABLE Docentes (
    id_docente INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    especialidad VARCHAR(80) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    estado VARCHAR(15) DEFAULT 'Activo'
);

CREATE TABLE Aulas (
    id_aula INT PRIMARY KEY AUTO_INCREMENT,
    nombre_aula VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL,
    edificio VARCHAR(50),
    piso INT,
    estado VARCHAR(15) DEFAULT 'Disponible'
);

CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(100) NOT NULL,
    descripcion TEXT,
    nivel VARCHAR(30) NOT NULL,
    anio_lectivo INT NOT NULL,
    id_docente INT NOT NULL,
    FOREIGN KEY (id_docente) REFERENCES Docentes(id_docente)
);

CREATE TABLE Horarios (
    id_horario INT PRIMARY KEY AUTO_INCREMENT,
    id_curso INT NOT NULL,
    id_aula INT NOT NULL,
    dia_semana VARCHAR(15) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso),
    FOREIGN KEY (id_aula) REFERENCES Aulas(id_aula)
);

CREATE TABLE Asistencias (
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    fecha DATE NOT NULL,
    estado_asistencia VARCHAR(15) NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

CREATE TABLE Calificaciones (
    id_calificacion INT PRIMARY KEY AUTO_INCREMENT,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    tipo_evaluacion VARCHAR(50) NOT NULL,
    calificacion DECIMAL(5,2) NOT NULL,
    fecha_evaluacion DATE NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

SHOW TABLES;

-- ========================================
-- PARTE 3: CREACION DE USUARIOS Y PERMISOS
-- ========================================

-- USUARIO 1: ADMINISTRADOR
CREATE USER IF NOT EXISTS 'admin_pet'@'%' IDENTIFIED BY 'AdminPet2024!';
GRANT ALL PRIVILEGES ON gestion_pet.* TO 'admin_pet'@'%';

-- USUARIO 2: SECRETARIA
CREATE USER IF NOT EXISTS 'secretaria_pet'@'%' IDENTIFIED BY 'SecretariaPet2024!';
GRANT SELECT, INSERT, UPDATE ON gestion_pet.Estudiantes TO 'secretaria_pet'@'%';
GRANT SELECT, INSERT, UPDATE ON gestion_pet.Docentes TO 'secretaria_pet'@'%';
GRANT SELECT, INSERT, UPDATE ON gestion_pet.Cursos TO 'secretaria_pet'@'%';
GRANT SELECT ON gestion_pet.Aulas TO 'secretaria_pet'@'%';
GRANT SELECT ON gestion_pet.Horarios TO 'secretaria_pet'@'%';

-- USUARIO 3: DOCENTE
CREATE USER IF NOT EXISTS 'docente_pet'@'%' IDENTIFIED BY 'DocentePet2024!';
GRANT SELECT ON gestion_pet.Estudiantes TO 'docente_pet'@'%';
GRANT SELECT ON gestion_pet.Cursos TO 'docente_pet'@'%';
GRANT SELECT ON gestion_pet.Docentes TO 'docente_pet'@'%';
GRANT SELECT, INSERT, UPDATE ON gestion_pet.Asistencias TO 'docente_pet'@'%';
GRANT SELECT, INSERT, UPDATE ON gestion_pet.Calificaciones TO 'docente_pet'@'%';

-- USUARIO 4: CONSULTA
CREATE USER IF NOT EXISTS 'consulta_pet'@'%' IDENTIFIED BY 'ConsultaPet2024!';
GRANT SELECT ON gestion_pet.* TO 'consulta_pet'@'%';

FLUSH PRIVILEGES;

-- VERIFICAR USUARIOS
SELECT User, Host FROM mysql.user WHERE User LIKE '%pet%';

SHOW GRANTS FOR 'admin_pet'@'%';
SHOW GRANTS FOR 'secretaria_pet'@'%';
SHOW GRANTS FOR 'docente_pet'@'%';
SHOW GRANTS FOR 'consulta_pet'@'%';