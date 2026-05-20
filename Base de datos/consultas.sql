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