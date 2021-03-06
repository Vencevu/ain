+flag (F): team(200)
  <-
  .register_service("servicio_soldado");
  .get_medics;
  .wait(1000); //Esperamos a que aparezca el general
  .get_service("general").

+general(G)
  <-
  .length(G, Len);
  if(Len==0){ //No hay general
    +planDeEmergencia;
  }
  if(Len>0){ //Seguimos comprobando que está vivo
    .wait(2000);
    .get_service("general");
    }
  -general(G).

+planDeEmergencia
  <-
  ?miEsquina(Esquina);
  .goto(Esquina).

//Disparamos a los enemigos que se acerquen
+enemies_in_fov(ID, TYPE, ANGLE, DIST, HEALTH, [X,Y,Z]): not planDeEmergencia
  <-
  .shoot([X,Y,Z],5).

//Perseguimos al enemigo y solicitamos refuezos
+enemies_in_fov(ID, TYPE, ANGLE, DIST, HEALTH, [X,Y,Z]): planDeEmergencia & not persiguiendo
  <-
  +persiguiendo; //Declaramos que estamos persiguiendo
  .get_service("servicio_soldado");
  .shoot([X,Y,Z],5);
  .goto([X,Y,Z]). //Perseguimos al enemigo

+servicio_soldado(S): planDeEmergencia //Vamos a avisar al resto de que encontramos un enemigo
  <-
  ?position(Pos);
  .send(S,tell,localizado(Pos)).

+localizado(Pos)[source(A)]: not persiguiendo //Vamos a perseguir al enemigo que nos han comunicado
  <-
  .goto(Pos).

+myMedics(M)
<-
  +agents([]);
  +pos([]);
  .send(M, tell, seguir); //Pide a un médico que le siga
  .wait(3000); //Espera respuestas
  +elegirmejor; 
  -myMedics(_).

+mybid(Pos)[source(A)] //Recibe las respuestas de los médicos que pueden acompañarle
  <- 
  ?agents(Ag);
  ?pos(Po); 
  .concat(Ag, [A], Ag1); //Va agregando a la lista el nombre del medico
  .concat(Po, [Pos], Po1); //Agrega la posicion de ese medico
  -+agents(Ag1);
  -+pos(Po1);
  -mybid(_).

//Elegimos el medico mas cercano
+elegirmejor: agents(Ag) & pos(Po)
  <-
  .masCercano(Ag, Po, X);
  .send(X, tell, te_elijo).

+asignado[source(Med)]: not mimedico(Med) //Un médico le pertenece ahora
  <-
  -asignado;
  +mimedico(Med);
  -elegirmejor.

+ocupado(P)[source(A)]: agents(Ag) & pos(Po) //El médico más cercano está ocupado
  <-
  .eliminarElem([A], Ag, Ag1); //Lo eliminamos de la lista
  .eliminarElem(P, Po, Po1);
  -+agents(Ag1);
  -+pos(Po1);
  +elegirmejor; //Elegimos entre los otros médicos
  -ocupado(_).

+ir(R1) : mimedico(Med) //Vamos a la posición que nos toca
  <-
  .goto(R1);
  .send(Med,tell,destino(R1));
  -ir(_).

//Ahora que tenemos el médico ya podemos formar (está duplicado porque puede ser mandado a formar antes o despues de tener medico)
+mimedico(Med) : ir(R1) 
  <-
  .goto(R1);
  .send(Med,tell,destino(R1));
  -ir(_).

+target_reached(T)
  <-
  ?flag(F);
  ?position(Pop);
  .dondeMiro(F,Pop,Esquina); //Funcion python que según donde se encuentre relativo a la bandera devuelve donde mirar
  +miEsquina(Esquina);
  .look_at(Esquina).

+alerta(EnePos)
  <-
  .goto(EnePos).