
Requerimientos

1. Crea y agrega al entregable las consultas para completar el setup de acuerdo a lo
pedido

2. Cruza los datos de la tabla usuarios y posts, mostrando las siguientes columnas:
nombre y email del usuario junto al título y contenido del post.

desafio3_sam_tang_123=# SELECT u.nombre, u.email, p.titulo, p.contenido FROM USUARIOS u JOIN POSTS p ON u.id = p.usuario_id;
  nombre  |        email        |   titulo    |       contenido
----------+---------------------+-------------+-----------------------
 Usuario1 | u1.correo@gmail.com | prueba      | contenido prueba
 Usuario1 | u1.correo@gmail.com | prueba2     | contenido prueba2
 Usuario2 | u2.correo@gmail.com | ejercicios  | contenido ejercicios
 Usuario2 | u2.correo@gmail.com | ejercicios2 | contenido ejercicios2
(4 rows)


3. Muestra el id, título y contenido de los posts de los administradores.

desafio3_sam_tang_123=# SELECT P.id, P.titulo, P.contenido
desafio3_sam_tang_123-# FROM posts P
desafio3_sam_tang_123-# INNER JOIN usuarios U
desafio3_sam_tang_123-# ON P.usuario_id = U.id
desafio3_sam_tang_123-# WHERE U.rol = 'ADMINISTRADOR';
 id | titulo  |     contenido
----+---------+-------------------
  1 | prueba  | contenido prueba
  2 | prueba2 | contenido prueba2
(2 rows)

4. Cuenta la cantidad de posts de cada usuario.

desafio3_sam_tang_123=# SELECT usuarios.id, usuarios.email, COUNT(posts.id) FROM usuarios LEFT
desafio3_sam_tang_123-# JOIN posts ON usuarios.id = posts.usuario_id GROUP BY usuarios.id,
desafio3_sam_tang_123-# usuarios.email;
 id |        email        | count
----+---------------------+-------
  5 | u5.correo@gmail.com |     0
  2 | u2.correo@gmail.com |     2
  1 | u1.correo@gmail.com |     2
  3 | u3.correo@gmail.com |     0
  4 | u4.correo@gmail.com |     0
(5 rows)

5. Muestra el email del usuario que ha creado más posts.
a. Aquí la tabla resultante tiene un único registro y muestra solo el email.

desafio3_sam_tang_123=# SELECT u.email FROM USUARIOS u JOIN POSTS p ON u.id = p.usuario_id
desafio3_sam_tang_123-#  GROUP BY u.id, u.email ORDER BY COUNT(p.id) DESC LIMIT 1;
        email
---------------------
 u2.correo@gmail.com
(1 row)

6. Muestra la fecha del último post de cada usuario.
desafio3_sam_tang_123=# SELECT fecha_creacion, contenido, usuario_id FROM comentarios WHERE id IN (SELECT MAX(id) FROM comentarios GROUP BY usuario_id) ORDER BY usuario_id;
 fecha_creacion |  contenido   | usuario_id
----------------+--------------+------------
 2021-06-04     | comentario 4 |          1
 2021-06-04     | comentario 5 |          2
 2021-06-04     | comentario 3 |          3
(3 rows)

7. Muestra el título y contenido del post (artículo) con más comentarios.

desafio3_sam_tang_123=# SELECT titulo, contenido FROM posts JOIN (SELECT post_id, COUNT(post_id)
desafio3_sam_tang_123(# FROM comentarios GROUP BY post_id ORDER BY count DESC LIMIT 1) AS c ON
desafio3_sam_tang_123-# posts.id = c.post_id;
 titulo |    contenido
--------+------------------
 prueba | contenido prueba
(1 row)


8. Muestra en una tabla el título de cada post, el contenido de cada post y el contenido
de cada comentario asociado a los posts mostrados, junto con el email del usuario
que lo escribió.

desafio3_sam_tang_123=# SELECT posts.titulo as titulo_post, posts.contenido as contenido_post,
desafio3_sam_tang_123-# comentarios.contenido as contenido_comentario, usuarios.email
desafio3_sam_tang_123-# FROM posts
desafio3_sam_tang_123-# JOIN comentarios ON posts.id = comentarios.post_id
desafio3_sam_tang_123-# JOIN usuarios ON comentarios.usuario_id = usuarios.id;
 titulo_post |  contenido_post   | contenido_comentario |        email
-------------+-------------------+----------------------+---------------------
 prueba      | contenido prueba  | comentario 1         | u1.correo@gmail.com
 prueba      | contenido prueba  | comentario 2         | u2.correo@gmail.com
 prueba      | contenido prueba  | comentario 3         | u3.correo@gmail.com
 prueba2     | contenido prueba2 | comentario 4         | u1.correo@gmail.com
 prueba2     | contenido prueba2 | comentario 5         | u2.correo@gmail.com
(5 rows)


9. Muestra el contenido del último comentario de cada usuario.

desafio3_sam_tang_123=# SELECT fecha_creacion, contenido, usuario_id FROM comentarios as c JOIN
desafio3_sam_tang_123-# usuarios as u ON c.usuario_id = u.id WHERE c.fecha_creacion = (SELECT
desafio3_sam_tang_123(# MAX(fecha_creacion) FROM comentarios WHERE usuario_id = u.id);
 fecha_creacion |  contenido   | usuario_id
----------------+--------------+------------
 2021-06-04     | comentario 4 |          1
 2021-06-04     | comentario 5 |          2
 2021-06-04     | comentario 3 |          3
(3 rows)


10. Muestra los emails de los usuarios que no han escrito ningún comentario.

desafio3_sam_tang_123=# SELECT usuarios.email FROM usuarios LEFT JOIN comentarios ON usuarios.id
desafio3_sam_tang_123-# = comentarios.usuario_id GROUP BY usuarios.email HAVING
desafio3_sam_tang_123-# COUNT(comentarios.id) = 0;
        email
---------------------
 u5.correo@gmail.com
 u4.correo@gmail.com
(2 rows)




