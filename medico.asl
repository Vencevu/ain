+flag (F)
  <-
  .wait(2000);
  .get_service("general").

+general(G)
  <-
  .print("Mi general es ", G).

+seguir[source(A)]: not siguiendo
<-
?name(N);
?position(P);
.send(A, tell, mybid(P));
-seguir;
.print("enviada propuesta de ayuda a ",A).


+te_elijo[source(A)]: not siguiendo
  <-
  +siguiendo;
  -te_elijo;
  .send(A, tell, asignado);
  .print("estoy siguiendo a ", A).

+te_elijo[source(A)]: siguiendo
  <-
  ?position(P);
  .send(A, tell, ocupado(P));
  -te_elijo;
  .print("Ya estoy siguiendo a alguien").