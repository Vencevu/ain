+flag (F): team(200)
  <-
  ?position(Pi);
  +posini(Pi);
  .get_service("general").

+friends_in_fov(ID,Type,Angle,Distance,Health,Pos): siguiendo(ID) //Seguimos a nuestro soldado asignado
  <-
  .goto(Pos).

+seguir[source(A)]: not siguiendo(_) //Un soldado nos pide nuestra posición para que le sigamos
  <-
  ?name(N);
  ?posini(Pi);
  .send(A, tell, mybid(Pi));
  -seguir.

+target_reached(T)
  <-
  +curar.


+curar
  <-
  .cure;
  .wait(4000);
  -+curar.

+te_elijo[source(A)]: not siguiendo(_) //Nos elige un soldado y no estamos asignados a ninguno
  <-
  +siguiendo(A);
  -te_elijo;
  .send(A, tell, asignado).

+te_elijo[source(A)]: siguiendo(_) //Nos elige un soldado pero ya estamos asignados a otro
  <-
  ?posini(Pi);
  .send(A, tell, ocupado(Pi));
  -te_elijo.

+destino(R1)[source(A)]
  <-
  .goto(R1);
  -destino(_).