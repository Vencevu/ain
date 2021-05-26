+flag (F)
  <-
  .f(F, R);
  .print("Posiciones ",R);
  .register_service("general");
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
  .print("Lista de tropas", S);
  .print("MANDO TROPAS");
  .primerElem(S, S1);
  .primerElem(R, R1);
  .print("Primer soldado", S1);
  .print("Posicion del primer soldado", R1);
  .send(S1, tell, ir(R1));
  .del(0,S,Sn);
  .del(0,R,Rn);
  .print("Lista restante de soldados", Sn);
  .print("Lista de posiciones de los soldados restantes", Rn);
  -+sitios(Rn);
  -mandarTropas(_);
  +continue(Sn).