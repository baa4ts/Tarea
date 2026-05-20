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