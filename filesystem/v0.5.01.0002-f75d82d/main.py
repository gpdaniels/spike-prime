"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub

from ui.runner import runner
from ui.system import loop
from ui.boot import bootup_animation

from programs.menu import Menu
from programs.standalone import Standalone


# ----------------------------------------------------------------------------

if hub.info().get('product_variant') == 1:
    standalone_image = hub.Image.GO_RIGHT
    cancel_image = hub.Image.GO_RIGHT
else:
    standalone_image = hub.Image.HEART
    cancel_image = hub.Image.HEART

# ----------------------------------------------------------------------------


bootup_animation()


menu = Menu()
menu.add_program(Standalone(standalone_image))

runner.startup(cancel_image)
runner.run_program(menu)

loop.run_forever()

runner.on_program_loop_cancelled()
