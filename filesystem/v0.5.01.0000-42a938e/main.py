"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
from ui.runner import runner
from ui.system import loop
from ui.boot import bootup_animation

from programs.menu import Menu
from programs.standalone import Standalone


bootup_animation()


menu = Menu()
menu.add_program(Standalone())

runner.startup()
runner.run_program(menu)

loop.run_forever()

