1. Listado de alumnos que cursaron materias juntos, pero en esta materia son de distintos
grupos.

MATCH (Pa:Persona)-[RA:CURSARON]->(M:Materia)<-[RB:CURSARON]-(Pb:Persona)
WHERE RA.grupo <> RB.grupo
RETURN DISTINCT Pa.apellido, Pb.apellido, M.nombre;

╒═════════════╤═════════════╤════════════╕
│"Pa.apellido"│"Pb.apellido"│"M.nombre"  │
╞═════════════╪═════════════╪════════════╡
│"Arancibia"  │"López"      │"Blockchain"│
├─────────────┼─────────────┼────────────┤
│"García"     │"López"      │"Blockchain"│
├─────────────┼─────────────┼────────────┤
│"López"      │"Arancibia"  │"Blockchain"│
├─────────────┼─────────────┼────────────┤
│"López"      │"García"     │"Blockchain"│
├─────────────┼─────────────┼────────────┤
│"Corrado"    │"Ferreira"   │"Big Data"  │
├─────────────┼─────────────┼────────────┤
│"Díaz"       │"Ferreira"   │"Big Data"  │
├─────────────┼─────────────┼────────────┤
│"Ferreira"   │"Corrado"    │"Big Data"  │
├─────────────┼─────────────┼────────────┤
│"Ferreira"   │"Díaz"       │"Big Data"  │
└─────────────┴─────────────┴────────────┘

2. Listado de docentes que dictaron más de una materia.
MATCH (D:Persona)-[R:DICTARON]->(M:Materia)
WITH D, count(R) AS Cantidad
WHERE Cantidad > 1
RETURN D.apellido as Apellido, D.nombre as Nombre;

╒═══════════╤═════════╕
│"Apellido" │"Nombre" │
╞═══════════╪═════════╡
│"Ferreira" │"Natalia"│
├───────────┼─────────┤
│"Arancibia"│"Pablo"  │
└───────────┴─────────┘

3. Tu propio promedio de calificaciones
MATCH (A:Persona {apellido: "Arancibia"})-[R:CURSARON]->(M:Materia)
RETURN A. apellido as Apellido, A.nombre as Nombre, avg(R.calificación) as Promedio

╒═══════════╤════════╤═════════════════╕
│"Apellido" │"Nombre"│"Promedio"       │
╞═══════════╪════════╪═════════════════╡
│"Arancibia"│"Pablo" │9.333333333333334│
└───────────┴────────┴─────────────────┘

4. Listado para recomendación de alumnos que cursaron en el mismo curso y cuatrimestre
pero no se conocen entre sí.

MATCH (Pa:Persona)-[RA:CURSARON]->(M:Materia)<-[RB:CURSARON]-(Pb:Persona)
WHERE RA.curso = RB.curso and RA.cuatrimestre = RB.cuatrimestre
and not (Pa)-[:CONOCE]-(Pb)
RETURN DISTINCT Pa.apellido as Apellido, Pb.apellido as Nombre, M.nombre as Materia

╒═══════════╤═══════════╤════════════╕
│"Apellido" │"Nombre"   │"Materia"   │
╞═══════════╪═══════════╪════════════╡
│"Dominguez"│"Raul"     │"Fisica"    │
├───────────┼───────────┼────────────┤
│"Raul"     │"Dominguez"│"Fisica"    │
├───────────┼───────────┼────────────┤
│"Arancibia"│"López"    │"Blockchain"│
├───────────┼───────────┼────────────┤
│"López"    │"Arancibia"│"Blockchain"│
├───────────┼───────────┼────────────┤
│"Corrado"  │"Ferreira" │"Big Data"  │
├───────────┼───────────┼────────────┤
│"Ferreira" │"Corrado"  │"Big Data"  │
└───────────┴───────────┴────────────┘

5. Listado de los conocidos de tus conocidos, hasta longitud 2, e indefinida.

MATCH (P:Persona {apellido: "Arancibia"})-[R:CONOCE*..2]->(P2:Persona)
RETURN DISTINCT P, P2

{imagen}

6. Apellido y nombre de alumnos que también son docentes (ver pedido adicional para esta
consulta).

MATCH (P:Persona)
WHERE EXISTS ((P:Persona)-[:ESROL]->(:Rol {nombre:"docente"}))
AND EXISTS ((P:Persona)-[:ESROL]->(:Rol {nombre:"alumno"}))
RETURN P.apellido as Apellido, P.nombre as Nombre;

╒═══════════╤═════════╕
│"Apellido" │"Nombre" │
╞═══════════╪═════════╡
│"Arancibia"│"Pablo"  │
├───────────┼─────────┤
│"López"    │"Mario"  │
├───────────┼─────────┤
│"Ferreira" │"Natalia"│
└───────────┴─────────┘

6.a Variante de 6. Se supone que si dictaron y cursaron materias es porque son ambos roles.

MATCH (P:Persona)
WHERE EXISTS ((P:Persona)-[:CURSARON]->(:Materia))
AND EXISTS ((P:Persona)-[:DICTARON]->(:Materia))
RETURN P.apellido as Apellido, P.nombre as Nombre;

╒═══════════╤═════════╕
│"Apellido" │"Nombre" │
╞═══════════╪═════════╡
│"Arancibia"│"Pablo"  │
├───────────┼─────────┤
│"López"    │"Mario"  │
├───────────┼─────────┤
│"Ferreira" │"Natalia"│
└───────────┴─────────┘

7. Dado un alumno en particular, se quiere obtener el listado de materias electivas que no
haya cursado, en base al criterio de haber sido cursadas por otros alumnos que cursaron
por lo menos una en común con él.

MATCH (Ma:Materia {tipo:"Electiva"}),(Pa:Persona {apellido: "Raul"})-[:CURSARON]->(Mb:Materia)<-[:CURSARON]-(Pb:Persona)
WHERE not EXISTS ((Pa: Persona {apellido: "Raul"})-[:CURSARON]->(Ma:Materia {tipo:"Electiva"}))
and EXISTS ((Pb: Persona)-[:CURSARON]->(Ma:Materia {tipo:"Electiva"}))
RETURN Ma as Materia

╒═════════════════════════════════════════╕
│"Materia"                                │
╞═════════════════════════════════════════╡
│{"nombre":"Blockchain","tipo":"Electiva"}│
└─────────────────────────────────────────┘


8. Hacer una variante del ítem anterior, recomendando sólo si el otro alumno es un contacto
(directo o indirecto)

MATCH (Ma:Materia {tipo:"Electiva"}),(Pa:Persona {apellido: "Raul"})-[:CURSARON]->(Mb:Materia)<-[:CURSARON]-(Pb:Persona)
WHERE not EXISTS ((Pa: Persona {apellido: "Raul"})-[:CURSARON]->(Ma:Materia {tipo:"Electiva"}))
and EXISTS ((Pb: Persona)-[:CURSARON]->(Ma:Materia {tipo:"Electiva"}))
AND EXISTS ((Pa:Persona)-[:CONOCE*..]-(Pb:Persona))
RETURN Ma as Materia

╒═════════════════════════════════════════╕
│"Materia"                                │
╞═════════════════════════════════════════╡
│{"nombre":"Blockchain","tipo":"Electiva"}│
└─────────────────────────────────────────┘


9. Consulta adicional, decidida por el alumno.
Docente que Dictó una materia sin haberla cursado, 
mostrar además docente que NO dicto esa materia pero SI la curso.

MATCH (Pa:Persona)-[:DICTARON]->(Mb:Materia),(Pb:Persona)-[:ESROL]->(R:Rol {nombre: "docente"})
WHERE not EXISTS ((Pa: Persona)-[:CURSARON]->(Mb:Materia))
and EXISTS ((Pb:Persona)-[:CURSARON]->(Mb:Materia))
RETURN Pa.apellido as Dicto , Mb as Materia, Pb.apellido as DocenteSiCurso

╒═══════════╤══════════════════════════════════════════╤════════════════╕
│"Dicto"    │"Materia"                                 │"DocenteSiCurso"│
╞═══════════╪══════════════════════════════════════════╪════════════════╡
│"Ferreira" │{"nombre":"Blockchain","tipo":"Electiva"} │"López"         │
├───────────┼──────────────────────────────────────────┼────────────────┤
│"Ferreira" │{"nombre":"Blockchain","tipo":"Electiva"} │"Arancibia"     │
├───────────┼──────────────────────────────────────────┼────────────────┤
│"López"    │{"nombre":"IoT","tipo":"obligatoria"}     │"Arancibia"     │
├───────────┼──────────────────────────────────────────┼────────────────┤
│"Arancibia"│{"nombre":"Big Data","tipo":"obligatoria"}│"Ferreira"      │
└───────────┴──────────────────────────────────────────┴────────────────┘