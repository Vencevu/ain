+flag (F)
  <-
  .get_service("general");
  .register_service("servicio_soldado");
  .get_medics.

+general(G)
  <-
  .print("Mi general es ", G).

+myMedics(M)
<-
  .print(M);
  +agents([]);
  +pos([]);
  .send(M, tell, seguir);
  .wait(3000); 
  +elegirmejor;
  -myMedics(_).

+mybid(Pos)[source(A)]
  <- 
  ?agents(Ag);
  ?pos(Po); 
  .concat(Ag, [A], Ag1);
  .concat(Po, [Pos], Po1);
  -+agents(Ag1);
  -+pos(Po1);
  -mybid(_).

+elegirmejor: agents(Ag) & pos(Po)
  <-
  .masCercano(Ag, Po, X);
  .send(X, tell, te_elijo).

+asignado[source(Med)]
  <-
  .print("Mi medico es ", Med);
  -asignado;
  +mimedico(Med);
  -elegirmejor.

+ocupado(P)[source(A)]: agents(Ag) & pos(Po)
  <-
  .eliminarElem([A], Ag, Ag1);
  .eliminarElem(P, Po, Po1);
  -+agents(Ag1);
  -+pos(Po1);
  +elegirmejor;
  -ocupado(_).

+ir(R1) : mimedico(Med)
  <-
  .print("De camino a ", R1);
  .goto(R1);
  .send(Med,tell,destino(R1));
  -ir(_).

+mimedico(Med) : ir(R1)
  <-
  .print("De camino a ", R1);
  .goto(R1);
  .send(Med,tell,destino(R1));
  -ir(_).