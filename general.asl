+flag (F)
  <-
  .register_service("general");
  .f(F, R);
  +sitios(R);
  .get_service("servicio_soldado");
  .print("Soy general Robot2: la venganza").

+servicio_soldado(S)
  <-
  +mandarTropas(S);
  -servicio_soldado(_).

+continue(Sn)
  <-
  +mandarTropas(Sn);
  -continue(_).

+mandarTropas(S): sitios(R) & not(S == [])
  <-
  .print("MANDO TROPAS");
  .primerElem(S, S1);
  .primerElem(R, R1);
  .send(S1, tell, ir(R1));
  .del(0,S,Sn);
  .del(0,R,Rn);
  -+sitios(Rn);
  -mandarTropas(_);
  +continue(Sn).