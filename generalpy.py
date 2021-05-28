import json
import random
from loguru import logger
from spade.behaviour import OneShotBehaviour
from spade.template import Template
from spade.message import Message
from pygomas.bditroop import BDITroop
from pygomas.bdifieldop import BDIFieldOp
from agentspeak import Actions
from agentspeak import grounded
from agentspeak.stdlib import actions as asp_action
from pygomas.ontology import DESTINATION
from pygomas.agent import LONG_RECEIVE_WAIT

class BDIGen(BDITroop):

    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)

        
        @actions.add_function(".f", (tuple, ))
        def _f(Flag):
            """
            Devuelve los cuatro puntos del mapa respectivos a los vertices
            de un cuadrado centrado en Flag y de lado side

            param: Flag: posicion en la que centrar el cuadrado.

            return: Tupla con los cuatro vertices del cuadrado
            """
            x = Flag[0]
            y = Flag[2]
            side = 30
            pos1 = (x-(side/2), 0, y-(side/2))
            pos2 = (x+(side/2), 0, y-(side/2))
            pos3 = (x+(side/2), 0, y+(side/2))
            pos4 = (x-(side/2), 0, y+(side/2))
            return (pos1,pos2,pos3,pos4) 

        @actions.add_function(".primerElem",(tuple, ))
        def _primerElem(l):
            """
            Devuelve el primer elemento de la lista l
            
            param: l: lista de la cual extraer el primer elemento.

            return: primer elemento de la lista l.
            """
            return l[0]

        @actions.add_function(".del", (int, tuple, ))
        def _del(pos, l):
            """
            Elimina el elemento de la posicion pos de la lista l

            param:  pos: posición de la lista a borrar
                    l: lista cuyo elemento queremos borrar
            """
            if pos == 0:
                return l[1:]
            elif pos == len(l) - 1:
                return l[:pos]
            else:
                return l[0:pos] + l[pos+1:]
