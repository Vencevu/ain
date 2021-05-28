+ir(R) //Recibo coordenadas
  <-
  +control_points(R);
  .length(R,L);
  +total_control_points(L);
  +patrolling;
  +patroll_point(0).

+target_reached(T): patrolling
  <-
  .reload;
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


