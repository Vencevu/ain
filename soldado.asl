+flag (F)
<-
  .create_control_points(F,25,3,C);
  +control_points(C);
  .length(C,L);
  +total_control_points(L);
  +patrolling;
  +patroll_point(0);
  .print("Got control points");
  .get_medics.

+target_reached(T): patrolling
  <-
  ?patroll_point(P);
  -+patroll_point(P+1);
  -target_reached(T).

+patroll_point(P): total_control_points(T) & P<T
  <-
  ?control_points(C);
  .nth(P,C,A);
  .goto(A).

+patroll_point(P): total_control_points(T) & P==T
  <-
  -patroll_point(P);
  +patroll_point(0).

+myMedics(M)
<-
  .print(M);
  +agents([]);
  +pos([]);
  .send(M, tell, seguir);
  .wait(1000); 
  !!elegirmejor;
  -myMedics(_).

+mybid(Pos)[source(A)]
<- 
  .print("Recibo propuesta");
  ?agents(Ag);
  ?pos(Po); 
  .concat(Ag, [A], Ag1);
  .concat(Po, [Pos], Po1);
  -+agents(Ag1);
  -+pos(Po1);
  -mybid(_).

+!elegirmejor: agents(Ag) & pos(Po)
  <-
  .print("Selecciono el mejor");
  .masCercano(Ag, Po, X);
  .print(X);
  .send(X, tell, te_elijo);
  -+pos([]);
  -+agents([]).

+ocu[source(A)]: agents(Ag) & pos(Po)
<-
  .eliminarElem(Ag, A);
  .print("Buscando otro medico").