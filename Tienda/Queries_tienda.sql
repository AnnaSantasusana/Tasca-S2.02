USE tienda;

-- 1. Llista el nom de tots els productes que hi ha en la taula producto.
SELECT p.nombre FROM producto AS p;

-- 2. Llista els noms i els preus de tots els productes de la taula producto.
SELECT p.nombre, p.precio FROM producto AS p;

-- 3. Llista totes les columnes de la taula producto.
SELECT * FROM producto;

-- 4. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT p.nombre, p.precio AS precio_EUR, ROUND(p.precio * 1.08, 2) AS precio_USD FROM producto p;

-- 5. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT p.nombre AS "Nom de produce", p.precio AS Euros, ROUND(p.precio * 1.08, 2) AS Dòlars FROM producto p;

-- 6. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(p.nombre), p.precio FROM producto p;

-- 7. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(p.nombre), p.precio FROM producto p;

-- 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT f.nombre, CONCAT(UPPER(LEFT(f.nombre, 2)),LOWER(SUBSTRING(f.nombre, 3))) FROM fabricante f;

-- 9. Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT p.nombre, ROUND(p.precio) FROM producto p;

-- 10. Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT p.nombre, TRUNCATE(p.precio, 0) FROM producto p;

-- 11. Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT f.codigo FROM fabricante f INNER JOIN producto p WHERE f.codigo = p.codigo_fabricante;

-- 12. Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT f.codigo FROM fabricante f INNER JOIN producto p WHERE f.codigo = p.codigo_fabricante;

-- 13. Llista els noms dels fabricants ordenats de manera ascendent.
SELECT f.nombre FROM fabricante f ORDER BY f.nombre;

-- 14. Llista els noms dels fabricants ordenats de manera descendent.
SELECT f.nombre FROM fabricante f ORDER BY f.nombre DESC;

-- 15. Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT p.nombre FROM producto p ORDER BY p.nombre, p.precio DESC;

-- 16. Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 5;

-- 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 3, 2;

-- 18. Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT p.nombre, p.precio FROM producto p ORDER BY p.precio LIMIT 1;

-- 19. Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT p.nombre, p.precio FROM producto p ORDER BY p.precio DESC LIMIT 1;

-- 20.Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT p.nombre FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.codigo = 2;

-- 21. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT p.nombre AS "Nombre producto", p. precio, f.nombre AS "Nombre fabricante" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante;

-- 22. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT p.nombre AS "Nombre producto", p. precio, f.nombre AS "Nombre fabricante" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante ORDER BY f.nombre;

-- 23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT p.codigo AS "Código producto", p.nombre AS "Nombre producto", f.codigo AS "Código fabricante", f.nombre AS "Nombre fabricante" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante;

-- 24. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT p.nombre AS "Nombre producto", p.precio, f.nombre AS "Nombre fabricante" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.precio = (SELECT MIN(precio) FROM producto);

-- 25. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT p.nombre AS "Nombre producto", p.precio, f.nombre AS "Nombre fabricante" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.precio = (SELECT MAX(precio) FROM producto);

-- 26. Retorna una llista de tots els productes del fabricant Lenovo.
SELECT p.nombre AS "Nombre producto" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.nombre = "Lenovo";

-- 27. etorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT p.nombre AS "Nombre producto" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.nombre = "Crucial" AND p.precio > "200";

-- 28. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Sense utilitzar l'operador IN.
SELECT p.nombre AS "Nombre producto" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.nombre = "Asus" OR f.nombre = "Hewlett-Packard" OR f.nombre = "Seagate";

-- 29. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Fent servir l'operador IN.
SELECT p.nombre AS "Nombre producto" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.nombre IN ("Asus", "Hewlett-Packard", "Seagate");

-- 30. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT p.nombre AS "Nombre producto", p.precio FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.nombre REGEXP "e$";

-- 31. Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT p.nombre AS "Nombre producto", p.precio FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.nombre REGEXP "w";

-- 32. Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT p.nombre AS "Nombre producto", p.precio, f.nombre AS "Nombre fabricante" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.precio >= "180" ORDER BY p.precio DESC, p.nombre;

-- 33.Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT f.codigo, f.nombre AS "Nombre fabricante" FROM fabricante f INNER JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 34. Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT f.nombre AS "Nombre fabricante", p.nombre AS "Nombre producto" FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 35. Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT f.codigo, f.nombre AS "Nombre fabricante" FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.nombre IS NULL;

-- 36. Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT p.nombre AS "Nombre producto" FROM producto p LEFT JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE f.nombre = "Lenovo";

-- 37. Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
SELECT * FROM producto p LEFT JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.precio = (SELECT MAX(precio) FROM producto WHERE f.nombre = "Lenovo");

-- 38. Llista el nom del producte més car del fabricant Lenovo.
SELECT p.nombre AS "Nombre producto" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.precio = (SELECT MAX(precio) FROM producto p1 INNER JOIN fabricante f1 ON f1.codigo = p1.codigo_fabricante WHERE f1.nombre = "Lenovo");

-- 39. Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT p.nombre AS "Nombre producto" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.precio = (SELECT MIN(precio) FROM producto p1 INNER JOIN fabricante f1 ON f1.codigo = p1.codigo_fabricante WHERE f1.nombre = "Hewlett-Packard");

-- 40. Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT p.nombre AS "Nombre producto" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.precio >= (SELECT MAX(precio) FROM producto p1 INNER JOIN fabricante f1 ON f1.codigo = p1.codigo_fabricante WHERE f1.nombre = "Lenovo");

-- 41. Llista tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT p.nombre AS "Nombre producto" FROM producto p INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.precio > (SELECT AVG(precio) FROM producto p1 WHERE f.codigo = p1.codigo_fabricante AND f.nombre = "Asus");