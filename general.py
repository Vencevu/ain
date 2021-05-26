import json
import random
from loguru import logger
from spade.behaviour import OneShotBehaviour
from spade.template import Template
from spade.message import Message
from pygomas.bditroop import BDITroop
from pygomas.bdisoldier import BDISoldier
from agentspeak import Actions
from agentspeak import grounded
from agentspeak.stdlib import actions as asp_action
from pygomas.ontology import DESTINATION
from pygomas.agent import LONG_RECEIVE_WAIT

class BDIGeneral(BDISoldier, BDITroop):

    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)

        @actions.add_function(".formCuad",(tuple, tuple, ))
        def _formCuad(Flag, Enemigos):
            xFlag = Flag[0]
            zFlag = Flag[2]
            return self.get_square_plot(xFlag, zFlag, 30)
        
        @actions.add_function(".formLine",(tuple, ))
        def _formCuad(Flag):
            xFlag = Flag[0]
            zFlag = Flag[2]
            xBase = self.map.allied_base.get_init_x() - self.map.allied_base.get_end_x()
            zBase = self.map.allied_base.get_init_z() - self.map.allied_base.get_end_z()


    def get_square_plot(self, x, y, side):
        return [(x-(side/2), 0, y+(side/2)), (x+(side/2), 0, y+(side/2)), (x-(side/2), 0, y-(side/2)), (x-(side/2), 0, y-(side/2))]
    
    def get_line(self, xF, zF, xB, zB):
        line = [(), 0, ()]


