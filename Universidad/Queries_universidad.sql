USE universidad;

-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p WHERE p.tipo = "alumno" ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p WHERE p.tipo = "alumno" AND p.telefono IS NULL;

-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT p.* FROM persona p WHERE p.tipo = "alumno" AND YEAR(p.fecha_nacimiento) = 1999;

-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT p.* FROM persona p WHERE p.tipo = "profesor" AND p.telefono IS NULL AND p.nif REGEXP "K$";

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT a.nombre FROM asignatura a JOIN grado g ON a.id_grado = g.id WHERE a.cuatrimestre = 1 AND a.curso = 3 AND g.id = 7;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS 'Departamento' FROM persona p JOIN profesor prof ON p.id = prof.id_profesor JOIN departamento d ON prof.id_departamento = d.id ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM alumno_se_matricula_asignatura am JOIN asignatura a ON am.id_asignatura = a.id JOIN curso_escolar ce ON am.id_curso_escolar = ce.id JOIN persona p ON am.id_alumno = p.id WHERE p.nif = "26902806M";

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre AS 'Departamento' FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON p.id_profesor = a.id_profesor JOIN grado g ON a.id_grado = g.id WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)";

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT p.* FROM persona p JOIN alumno_se_matricula_asignatura am ON p.id = am.id_alumno JOIN curso_escolar ce ON am.id_curso_escolar = ce.id WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT d.nombre AS 'Departamento', p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN departamento d ON prof.id_departamento = d.id WHERE p.tipo = "profesor" ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT p.* FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN departamento d ON prof.id_departamento = d.id WHERE p.tipo = "profesor" AND d.nombre IS NULL;

-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT d.nombre FROM departamento d LEFT JOIN profesor prof ON prof.id_departamento = d.id WHERE prof.id_departamento IS NULL;

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT p.* FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE p.tipo = "profesor" AND a.id_profesor IS NULL;

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT a.nombre FROM asignatura a LEFT JOIN profesor prof ON a.id_profesor = prof.id_profesor WHERE a.id_profesor IS NULL;

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT d.nombre FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE a.curso IS NULL;

-- Consultes resum:

-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(p.id) AS "Nombre total d'alumnes" FROM persona p WHERE p.tipo = "alumno";

-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(p.id) AS "Alumnes nascuts al 1999" FROM persona p WHERE p.tipo = "alumno" AND YEAR(p.fecha_nacimiento) = 1999;

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT d.nombre AS "Nom departament", COUNT(prof.id_profesor) AS "Total professors" FROM departamento d JOIN profesor prof ON d.id = prof.id_departamento GROUP BY d.nombre ORDER BY COUNT(prof.id_profesor) DESC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre AS "Nom departament", COUNT(prof.id_profesor) AS "Nombre de professors/es" FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento GROUP BY d.nombre;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre AS "Nom grau", COUNT(a.id) AS "Nombre d'assignatures" FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY COUNT("Nombre d'assignatures") DESC;

-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT g.nombre AS "Nom grau", COUNT(a.id) AS "Nombre d'assignatures" FROM grado g JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING COUNT("Nombre d'assignatures") > 40 ;

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT g.nombre AS "Nom grau", SUM(a.creditos) AS "Crèdits totals", a.tipo AS "Tipus d'assignatura" FROM grado g JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo;

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT COUNT(am.id_alumno) AS "Nombre d'alumnes", ce.anyo_inicio AS "Any inici curs escolar" FROM curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura am ON ce.id = am.id_curso_escolar GROUP BY ce.id;

-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id_profesor) AS "Nombre d'assignatures" FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE p.tipo = "profesor" GROUP BY p.id ORDER BY COUNT("Nombre d'assignatures") DESC;

-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT p.* FROM persona p WHERE p.tipo = "alumno" AND p.fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona) GROUP BY p.id;

-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT p.* FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE prof.id_departamento IS NOT NULL AND a.id_profesor IS NULL; 