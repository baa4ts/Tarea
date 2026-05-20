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


-- ========================================
-- PARTE 4: INSERCION DE DATOS
-- ========================================

USE gestion_pet;

INSERT INTO Estudiantes (cedula, nombre_completo, fecha_nacimiento, direccion, telefono, email, fecha_ingreso, estado) VALUES
('12345678', 'Juan Perez Garcia', '2006-03-15', 'Av. Artigas 1234, Melo', '099111222', 'juan.perez@estudiante.pet.edu.uy', '2023-03-01', 'Activo'),
('23456789', 'Maria Rodriguez Lopez', '2005-07-22', 'Calle Treinta y Tres 567, Melo', '098333444', 'maria.rodriguez@estudiante.pet.edu.uy', '2023-03-01', 'Activo'),
('34567890', 'Carlos Fernandez Silva', '2006-11-10', 'Bvar. Batlle 890, Melo', '097555666', 'carlos.fernandez@estudiante.pet.edu.uy', '2023-03-01', 'Activo'),
('45678901', 'Ana Martinez Costa', '2005-05-18', 'Av. Brasil 2345, Melo', '096777888', 'ana.martinez@estudiante.pet.edu.uy', '2023-03-01', 'Activo');

INSERT INTO Docentes (cedula, nombre_completo, especialidad, telefono, email, fecha_contratacion, estado) VALUES
('11111111', 'Roberto Gonzalez Mendez', 'Matematicas', '099888777', 'roberto.gonzalez@docente.pet.edu.uy', '2020-02-15', 'Activo'),
('22222222', 'Laura Sanchez Vega', 'Lengua Espanola', '098666555', 'laura.sanchez@docente.pet.edu.uy', '2019-08-01', 'Activo'),
('33333333', 'Diego Ramirez Castro', 'Informatica', '097444333', 'diego.ramirez@docente.pet.edu.uy', '2021-03-10', 'Activo'),
('44444444', 'Patricia Alvarez Ruiz', 'Ciencias Sociales', '096222111', 'patricia.alvarez@docente.pet.edu.uy', '2018-04-20', 'Activo');

INSERT INTO Aulas (nombre_aula, capacidad, edificio, piso, estado) VALUES
('Aula 101', 30, 'Edificio Principal', 1, 'Disponible'),
('Aula 102', 35, 'Edificio Principal', 1, 'Disponible'),
('Aula 201', 28, 'Edificio Principal', 2, 'Disponible'),
('Laboratorio Informatica', 25, 'Edificio Tecnologico', 1, 'Disponible');

INSERT INTO Cursos (nombre_curso, descripcion, nivel, anio_lectivo, id_docente) VALUES
('Matematica I', 'Curso de matematica basica', '1er Anio', 2024, 1),
('Lengua y Literatura', 'Curso de lengua espanola y literatura', '1er Anio', 2024, 2),
('Informatica Basica', 'Introduccion a la informatica y programacion', '1er Anio', 2024, 3),
('Historia y Geografia', 'Curso de ciencias sociales', '1er Anio', 2024, 4);

INSERT INTO Horarios (id_curso, id_aula, dia_semana, hora_inicio, hora_fin) VALUES
(1, 1, 'Lunes', '08:00:00', '09:30:00'),
(1, 1, 'Miercoles', '08:00:00', '09:30:00'),
(2, 2, 'Martes', '10:00:00', '11:30:00'),
(3, 4, 'Jueves', '14:00:00', '16:00:00'),
(4, 3, 'Viernes', '08:00:00', '09:30:00');

INSERT INTO Asistencias (id_estudiante, id_curso, fecha, estado_asistencia, observaciones) VALUES
(1, 1, '2024-04-22', 'Presente', NULL),
(2, 1, '2024-04-22', 'Presente', NULL),
(3, 1, '2024-04-22', 'Ausente', 'Sin justificacion'),
(1, 2, '2024-04-23', 'Presente', NULL),
(2, 2, '2024-04-23', 'Tarde', 'Llego 15 minutos tarde');

INSERT INTO Calificaciones (id_estudiante, id_curso, tipo_evaluacion, calificacion, fecha_evaluacion, observaciones) VALUES
(1, 1, 'Parcial 1', 85.50, '2024-04-15', 'Buen desempeno'),
(2, 1, 'Parcial 1', 92.00, '2024-04-15', 'Excelente'),
(3, 1, 'Parcial 1', 68.00, '2024-04-15', 'Debe mejorar'),
(1, 2, 'Trabajo Practico', 78.00, '2024-04-18', NULL);


-- ========================================
-- PARTE 5: CONSULTAS SQL BASICAS
-- ========================================

USE gestion_pet;

-- CONSULTA 1: Listar todos los estudiantes activos
SELECT * FROM Estudiantes WHERE estado = 'Activo';

-- CONSULTA 2: Mostrar docentes y sus especialidades
SELECT nombre_completo, especialidad, email FROM Docentes WHERE estado = 'Activo';

-- CONSULTA 3: Ver todos los cursos con el nombre del docente
SELECT c.nombre_curso, c.nivel, d.nombre_completo AS docente
FROM Cursos c, Docentes d
WHERE c.id_docente = d.id_docente;

-- CONSULTA 4: Asistencias del dia 2024-04-22
SELECT e.nombre_completo, c.nombre_curso, a.estado_asistencia, a.observaciones
FROM Asistencias a, Estudiantes e, Cursos c
WHERE a.id_estudiante = e.id_estudiante
AND a.id_curso = c.id_curso
AND a.fecha = '2024-04-22';

-- CONSULTA 5: Calificaciones mayores a 80
SELECT e.nombre_completo, c.nombre_curso, ca.tipo_evaluacion, ca.calificacion
FROM Calificaciones ca, Estudiantes e, Cursos c
WHERE ca.id_estudiante = e.id_estudiante
AND ca.id_curso = c.id_curso
AND ca.calificacion > 80;

-- CONSULTA 6: Horarios de un curso especifico
SELECT c.nombre_curso, h.dia_semana, h.hora_inicio, h.hora_fin, a.nombre_aula
FROM Horarios h, Cursos c, Aulas a
WHERE h.id_curso = c.id_curso
AND h.id_aula = a.id_aula
AND c.id_curso = 1;

-- CONSULTA 7: Estudiantes que faltaron
SELECT e.nombre_completo, c.nombre_curso, a.fecha
FROM Asistencias a, Estudiantes e, Cursos c
WHERE a.id_estudiante = e.id_estudiante
AND a.id_curso = c.id_curso
AND a.estado_asistencia = 'Ausente';

-- CONSULTA 8: Aulas disponibles
SELECT * FROM Aulas WHERE estado = 'Disponible';