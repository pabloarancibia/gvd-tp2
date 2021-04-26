CREATE
(A: Persona {apellido: "Arancibia", nombre: "Pablo", email: "pablo@utn.com", fechanac:"01/01/1987", pais: "Argentina"}),
(B: Persona {apellido: "Montes de Oca", nombre: "Federico", email: "fede@utn.com", fechanac:"05/04/1986", pais: "Argentina"}),
(C: Persona {apellido: "Jessica", nombre: "Maidana", email: "jessica@utn.com", fechanac:"04/07/1989", pais: "Argentina"}),
(E: Persona {apellido: "Raul", nombre: "Garnest", email: "rgarnest@utn.com", fechanac:"31/12/1978", pais: "Argentina"}),
(F: Persona { apellido: "Corrado", nombre: "Gustavo", email: "gustavo.corrado@gmail.com", fechanac: "01/08/1966", pais: "Argentina" } ),
 (D: Persona { apellido: "Díaz", nombre: "Analía", email: "adiaz@hotmail.com", fechanac: "10/12/1978", pais: "Argentina" } ),
 (Do: Persona { apellido: "Dominguez", nombre: "Mariana", email: "mariana@yahoo.com", fechanac: "31/10/1990", pais: "Chile" } ),
 (P: Persona { apellido: "Pereyra", nombre: "Claudio", email: "cpereyra30@yahoo.com.ar", fechanac: "18/05/1993", pais: "Estados Unidos" } ),
 (L: Persona { apellido: "López", nombre: "Mario", email: "mario.lopez@gmail.com", fechanac: "11/02/1970", pais: "Argentina" } ),
 (Fa: Persona { apellido: "Ferreira", nombre: "Natalia", email: "nf@hotmail.com", fechanac: "07/04/1972", pais: "Argentina" } ),
 (G: Persona { apellido: "García", nombre: "Eduardo", email: "garcia@live.com.ar", fechanac: "23/01/1985", pais: "Chile" } ),
 (Go: Persona { apellido: "González", nombre: "Bibiana", email: "bibiana@live.com.ar", fechanac: "09/11/1974", pais: "España" } ),
 (Lu: Persona { apellido: "Lupis", nombre: "Jorge", email: "jlup@gmail.com", fechanac: "27/09/1980", pais: "Argentina" } ),
 (M: Persona { apellido: "Mendez", nombre: "Verónica", email: "veromendi@yahoo.com.ar", fechanac: "28/02/1968", pais: "Argentina" } );

CREATE
(Ma: Materia {nombre: "Fisica", tipo:"Electiva"}),
(Mb: Materia {nombre: "Blockchain", tipo:"Electiva"}),
(Md: Materia {nombre: "Solidity", tipo:"obligatoria"}),
(Mc: Materia {nombre: "IoT", tipo:"obligatoria"}),
(Me: Materia {nombre: "Smart City", tipo:"obligatoria"}),
(Mg: Materia {nombre: "Big Data", tipo:"obligatoria"});

CREATE
(ra: Rol {id:"1", nombre: "alumno"}),
(rb: Rol {id:"2", nombre: "docente"}),
(rc: Rol {id:"3", nombre: "preceptor"});

## Relaciones cursaron:
MATCH (P1: Persona { apellido: "Arancibia"}), (M1: Materia { nombre: "IoT"} ) 
MERGE (P1)-[:CURSARON {grupo: "A", curso: "2",año:"2021", cuatrimestre: "1", calificación: 10 } ]->(M1);
MATCH (P2: Persona { apellido: "Pereyra"}), (M2: Materia { nombre: "Solidity"} ) 
MERGE (P2)-[:CURSARON {grupo: "B", curso: "2",año:"2021", cuatrimestre: "1", calificación: 9 } ]->(M2);
MATCH (P3: Persona { apellido: "Díaz"}), (M3: Materia { nombre: "Big Data"} ) 
MERGE (P3)-[:CURSARON {grupo: "B", curso: "2",año:"2021", cuatrimestre: "1", calificación: 9 } ]->(M3);
MATCH (P4: Persona { apellido: "Corrado"}), (M4: Materia { nombre: "Big Data"} ) 
MERGE (P4)-[:CURSARON {grupo: "B", curso: "1",año:"2021", cuatrimestre: "2", calificación: 4 } ]->(M4);
MATCH (P5: Persona { apellido: "Ferreira"}), (M5: Materia { nombre: "Big Data"} ) 
MERGE (P5)-[:CURSARON {grupo: "A", curso: "1",año:"2020", cuatrimestre: "2", calificación: 3 } ]->(M5);
MATCH (P6: Persona { apellido: "García"}), (M6: Materia { nombre: "Blockchain"} ) 
MERGE (P6)-[:CURSARON {grupo: "C", curso: "1",año:"2020", cuatrimestre: "2", calificación: 9 } ]->(M6);
MATCH (P7: Persona { apellido: "Arancibia"}), (M7: Materia { nombre: "Blockchain"} ) 
MERGE (P7)-[:CURSARON {grupo: "C", curso: "4",año:"2020", cuatrimestre: "3", calificación: 8 } ]->(M7);
MATCH (P8: Persona { apellido: "López"}), (M8: Materia { nombre: "Blockchain"} ) 
MERGE (P8)-[:CURSARON {grupo: "A", curso: "4",año:"2021", cuatrimestre: "3", calificación: 10 } ]->(M8);
MATCH (P9: Persona { apellido: "Dominguez"}), (M9: Materia { nombre: "Fisica"} ) 
MERGE (P9)-[:CURSARON {grupo: "D", curso: "5",año:"2019", cuatrimestre: "2", calificación: 9 } ]->(M9);
MATCH (P10: Persona { apellido: "Raul"}), (M10: Materia { nombre: "Fisica"} ) 
MERGE (P10)-[:CURSARON {grupo: "D", curso: "5",año:"2019", cuatrimestre: "2", calificación: 9 } ]->(M10);
MATCH (P11: Persona { apellido: "Dominguez"}), (M10: Materia { nombre: "Blockchain"} ) 
MERGE (P11)-[:CURSARON {grupo: "D", curso: "5",año:"2019", cuatrimestre: "2", calificación: 9 } ]->(M10);

## Relaciones Dictaron
MATCH 
(PD1: Persona{apellido:"López"}), (MD1: Materia {nombre:"IoT"})
MERGE
(PD1)-[:DICTARON {curso: "3", cuatrimestre: "3", año: "2021"}]->(MD1);
MATCH 
(PD2: Persona{apellido:"Arancibia"}), (MD2: Materia {nombre:"Big Data"})
MERGE
(PD2)-[:DICTARON {curso: "2", cuatrimestre: "1", año: "2021"}]->(MD2);
MATCH 
(PD3: Persona{apellido:"Ferreira"}), (MD3: Materia {nombre:"Blockchain"})
MERGE
(PD3)-[:DICTARON {curso: "4", cuatrimestre: "3", año: "2021"}]->(MD3);
MATCH 
(PD4: Persona{apellido:"Arancibia"}), (MD4: Materia {nombre:"Solidity"})
MERGE
(PD4)-[:DICTARON {curso: "2", cuatrimestre: "1", año: "2021"}]->(MD4);
MATCH 
(PD5: Persona{apellido:"Ferreira"}), (MD5: Materia {nombre:"Fisica"})
MERGE
(PD5)-[:DICTARON {curso: "5", cuatrimestre: "2", año: "2019"}]->(MD5);


# Conoce
MATCH (CP1: Persona { apellido: "Arancibia"}), (PC1: Persona { apellido: "Corrado"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "Corrado"}), (PC1: Persona { apellido: "Díaz"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "Díaz"}), (PC1: Persona { apellido: "Ferreira"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "Corrado"}), (PC1: Persona { apellido: "Arancibia"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "Ferreira"}), (PC1: Persona { apellido: "Díaz"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "García"}), (PC1: Persona { apellido: "Montes de Oca"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "González"}), (PC1: Persona { apellido: "Lupis"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "Lupis"}), (PC1: Persona { apellido: "Raul"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "Mendez"}), (PC1: Persona { apellido: "Jessica"}) 
MERGE (CP1)-[:CONOCE]->(PC1);

MATCH (CP1: Persona { apellido: "Raul"}), (PC1: Persona { apellido: "Dominguez"}) 
MERGE (CP1)-[:CONOCE]->(PC1);


## Relaciones EsRol , para roles
MATCH (CP1: Persona { apellido: "Arancibia"}), (PC1: Rol { nombre: "docente"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "López"}), (PC1: Rol { nombre: "docente"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "Ferreira"}), (PC1: Rol { nombre: "docente"}) 
MERGE (CP1)-[:ESROL]->(PC1);

MATCH (CP1: Persona { apellido: "Arancibia"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "López"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "Ferreira"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "Pereyra"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "García"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "Corrado"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "Díaz"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "Dominguez"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);
MATCH (CP1: Persona { apellido: "Raul"}), (PC1: Rol { nombre: "alumno"}) 
MERGE (CP1)-[:ESROL]->(PC1);



