+flag (F)
  <-
  ?position(Pi);
  +posini(Pi);
  .get_service("general").

+general(G)
  <-
  .print("Mi general es ", G).

+seguir[source(A)]: not siguiendo
<-
?name(N);
?posini(Pi);
.send(A, tell, mybid(Pi));
-seguir.


+te_elijo[source(A)]: not siguiendo
  <-
  +siguiendo;
  -te_elijo;
  .send(A, tell, asignado).

+te_elijo[source(A)]: siguiendo
  <-
  ?posini(Pi);
  .send(A, tell, ocupado(Pi));
  -te_elijo.

+destino(R1)[source(A)]
  <-
  .goto(R1);
  -destino(_).