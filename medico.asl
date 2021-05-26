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
  .print("estoy siguiendo a ", A).

+te_elijo[source(A)]: siguiendo
  <-
  .send(A, tell, ocu);
  -te_elijo;
  .print("Ya estoy siguiendo a alguien").