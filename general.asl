+flag (F) //Inicializamos
  <-
  .register_service("general");
  .goto(F);
  .f(F, R); //Esta función calcula la formación Cuadrado para mandar a los soldados
  +sitios(R);
  .get_fieldops;
  .get_service("servicio_soldado");
  .print("Soy general Robot2: la venganza").

+target_reached(T)
  <-
  .print("HE LLEGADO");
  +posMirar([[0,0,0],[250,0,0],[250,0,250],[0,0,250]]); //Lista de sitios a los que va a mirar (esquinas del mapa)
  +loop(0); //Contador para el bucle de sitios a los que mirar
  !girar; //Va mirando a los sitios de "posMirar"
  -target_reached(T).

+myFieldops(Fo): sitios(R)
  <-
  .send(Fo, tell, ir(R));
  -myFieldops(_).

+servicio_soldado(S) //Este servicio lo tienen todos los soldados
  <-
  .print("voy a mandar tropas");
  +mandarTropas(S); //Mandamos las tropas cada una a una esquina
  -servicio_soldado(_).

+continue(Sn)
  <-
  .print("continuo mandando tropas");
  +mandarTropas(Sn);
  -continue(_).

+mandarTropas(S): sitios(R) & not(S == [])
  <-
  .print("MANDO TROPAS");
  .primerElem(S, S1); //Este metodo devuelve el primer elemento de una lista
  .primerElem(R, R1);
  .send(S1, tell, ir(R1)); //Mandamos a cada soldado su posición y la esquina del cuadrado que forma
  .del(0,S,Sn); //Borramos la posición de la lista
  .del(0,R,Rn);
  -+sitios(Rn);
  -mandarTropas(_);
  +continue(Sn).

+!girar: loop(E) & E<4  //Con esto girará mirando hacia cada esquina (similar al visto en clase)
  <-
  .print("ESTOY GIRANDO");
  ?posMirar(L);
  .nth(E, L, P);
  .look_at(P);
  .wait(1000);
  -loop(_);
  +loop(E+1);
  !girar.

+!girar: loop(E) & E=4 //Esto sirve para hacer reset de la lista y empezar otra vez en el lugar 1 al que mirar
  <-
  .print("giro muchisimo");
  -loop(_);
  +loop(0);
  !girar.