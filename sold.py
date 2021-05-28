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
from pygomas.ontology import HEALTH
from pygomas.agent import LONG_RECEIVE_WAIT

class BDISold(BDITroop):

    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)

        @actions.add_function(".masCercano", (tuple, tuple, ))
        def _masCercano(listaMedicos, listaPosiciones):
            soldX = self.movement.position.x
            soldZ = self.movement.position.z
            elegido = []
            n = 0
            minDist = 9999999
            if len(listaMedicos)>0:
                for med in listaPosiciones:
                    posX = med[0]
                    posZ = med[2]
                    dist = abs(soldX-posX) + abs(soldZ-posZ)
                    if dist < minDist:
                        minDist = dist
                        elegido = listaMedicos[n]
                    n += 1
            return tuple([elegido])
        
        @actions.add_function(".eliminarElem",(tuple,tuple, ))
        def _eliminarElem(elem,l):
            if len(elem) == 1:
                e = elem[0]
            else:
                e = elem
            return l[:l.index(e)] + l[l.index(e) + 1:]


        @actions.add_function(".dondeMiro",(tuple,tuple, ))
        def _dondeMiro(flag,pos):
            relX = pos[0] - flag[0]
            relZ = pos[2] - flag[2]
            print(relX)
            print(relZ)
            if relX > 0 and relZ > 0:
                return (220,0,220)
            elif relX > 0 and relZ < 0:
                return (220,0,30)
            elif relX < 0 and relZ < 0:
                return (30,0,30)
            else:
                return  (30,0,220)



