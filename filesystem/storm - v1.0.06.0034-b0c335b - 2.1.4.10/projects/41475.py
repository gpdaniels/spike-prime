from util.print_override import spikeprint;print = spikeprint
import hub
from runtime import MultiMotor, VirtualMachine
from util.rotation import rotate_hub_display_to_value
from util.scratch import clamp, compare, convert_animation_frame, percent_to_int, pitch_to_freq, to_number
from util.sensors import is_type

g_animation = ["0000000000000090000000000", "0000000000987650000000000"]

async def dogBotWalkForSeconds(vm, direction, time):
    yield
    if direction in ["forward", "back"]:
        multi = MultiMotor(vm)
        for port in "CD":
            (acceleration, deceleration) = vm.store.motor_acceleration(port)
            multi.run(port, vm.system.motors.on_port(port).run_to_position, 90, abs(vm.store.motor_speed(port)), "shortest", stall=vm.store.motor_stall(port), stop=vm.store.motor_stop(port), acceleration=acceleration, deceleration=deceleration)
        await multi.await_all()
        multi_1 = MultiMotor(vm)
        for port_1 in "AB":
            (acceleration_1, deceleration_1) = vm.store.motor_acceleration(port_1)
            multi_1.run(port_1, vm.system.motors.on_port(port_1).run_to_position, 270, abs(vm.store.motor_speed(port_1)), "shortest", stall=vm.store.motor_stall(port_1), stop=vm.store.motor_stop(port_1), acceleration=acceleration_1, deceleration=deceleration_1)
        await multi_1.await_all()
        if direction == "forward":
            vm.store.move_pair(("C", "D"))
            pair = vm.system.move.on_pair(*vm.store.move_pair())
            speeds = pair.from_steering(0, vm.store.move_speed())
            pair.start_at_speeds(speeds[0], -speeds[1])
            vm.store.move_pair(("A", "B"))
            pair = vm.system.move.on_pair(*vm.store.move_pair())
            speeds = pair.from_steering(0, vm.store.move_speed())
            pair.start_at_speeds(speeds[0], -speeds[1])
        else:
            vm.store.move_pair(("B", "A"))
            pair = vm.system.move.on_pair(*vm.store.move_pair())
            speeds = pair.from_steering(0, vm.store.move_speed())
            pair.start_at_speeds(speeds[0], -speeds[1])
            vm.store.move_pair(("D", "C"))
            pair = vm.system.move.on_pair(*vm.store.move_pair())
            speeds = pair.from_steering(0, vm.store.move_speed())
            pair.start_at_speeds(speeds[0], -speeds[1])
    else:
        if direction == "counterclockwise":
            (acceleration_2, deceleration_2) = vm.store.motor_acceleration("A")
            vm.store.motor_last_status("A", await vm.system.motors.on_port("A").run_to_position_async(270, abs(vm.store.motor_speed("A")), "shortest", stall=vm.store.motor_stall("A"), stop=vm.store.motor_stop("A"), acceleration=acceleration_2, deceleration=deceleration_2))
            (acceleration_3, deceleration_3) = vm.store.motor_acceleration("B")
            vm.store.motor_last_status("B", await vm.system.motors.on_port("B").run_to_position_async(45, abs(vm.store.motor_speed("B")), "shortest", stall=vm.store.motor_stall("B"), stop=vm.store.motor_stop("B"), acceleration=acceleration_3, deceleration=deceleration_3))
            (acceleration_4, deceleration_4) = vm.store.motor_acceleration("C")
            vm.store.motor_last_status("C", await vm.system.motors.on_port("C").run_to_position_async(90, abs(vm.store.motor_speed("C")), "shortest", stall=vm.store.motor_stall("C"), stop=vm.store.motor_stop("C"), acceleration=acceleration_4, deceleration=deceleration_4))
            (acceleration_5, deceleration_5) = vm.store.motor_acceleration("D")
            vm.store.motor_last_status("D", await vm.system.motors.on_port("D").run_to_position_async(315, abs(vm.store.motor_speed("D")), "shortest", stall=vm.store.motor_stall("D"), stop=vm.store.motor_stop("D"), acceleration=acceleration_5, deceleration=deceleration_5))
        else:
            (acceleration_6, deceleration_6) = vm.store.motor_acceleration("A")
            vm.store.motor_last_status("A", await vm.system.motors.on_port("A").run_to_position_async(135, abs(vm.store.motor_speed("A")), "shortest", stall=vm.store.motor_stall("A"), stop=vm.store.motor_stop("A"), acceleration=acceleration_6, deceleration=deceleration_6))
            (acceleration_7, deceleration_7) = vm.store.motor_acceleration("B")
            vm.store.motor_last_status("B", await vm.system.motors.on_port("B").run_to_position_async(270, abs(vm.store.motor_speed("B")), "shortest", stall=vm.store.motor_stall("B"), stop=vm.store.motor_stop("B"), acceleration=acceleration_7, deceleration=deceleration_7))
            (acceleration_8, deceleration_8) = vm.store.motor_acceleration("C")
            vm.store.motor_last_status("C", await vm.system.motors.on_port("C").run_to_position_async(225, abs(vm.store.motor_speed("C")), "shortest", stall=vm.store.motor_stall("C"), stop=vm.store.motor_stop("C"), acceleration=acceleration_8, deceleration=deceleration_8))
            (acceleration_9, deceleration_9) = vm.store.motor_acceleration("D")
            vm.store.motor_last_status("D", await vm.system.motors.on_port("D").run_to_position_async(90, abs(vm.store.motor_speed("D")), "shortest", stall=vm.store.motor_stall("D"), stop=vm.store.motor_stop("D"), acceleration=acceleration_9, deceleration=deceleration_9))
        vm.store.move_pair(("C", "D"))
        pair = vm.system.move.on_pair(*vm.store.move_pair())
        speeds = pair.from_steering(0, 50)
        pair.start_at_speeds(speeds[0], -speeds[1])
        vm.store.move_pair(("A", "B"))
        pair = vm.system.move.on_pair(*vm.store.move_pair())
        speeds = pair.from_steering(0, 50)
        pair.start_at_speeds(speeds[0], -speeds[1])
    yield round(clamp(to_number(time) * 1000, 0, 86400000))
    vm.store.move_pair(("C", "D"))
    pair = vm.system.move.on_pair(*vm.store.move_pair())
    pair.stop(vm.store.move_stop())
    vm.store.move_pair(("A", "B"))
    pair = vm.system.move.on_pair(*vm.store.move_pair())
    pair.stop(vm.store.move_stop())

async def dogBotSetSpeed(vm, speed):
    yield
    if speed == 0:
        vm.store.move_speed(0)
    elif speed > 100:
        vm.store.move_speed(60)
    elif speed < -100:
        vm.store.move_speed(-60)
    elif speed < 0:
        vm.store.move_speed(round(clamp(round((speed * 0.3) - 30), -100, 100)))
    else:
        vm.store.move_speed(round(clamp(round((speed * 0.3) + 30), -100, 100)))

async def stack_1(vm, stack):
    port = getattr(hub.port, "E", None)
    if getattr(port, "device", None) and is_type("E", 62):
        port.device.mode(5, bytes("".join([chr(percent_to_int(round(clamp(to_number(p), 0, 100)), 87)) for p in "100 100 100 100".split()]), "utf-8"))
    rotate_hub_display_to_value("3")
    global g_animation
    brightness = vm.store.display_brightness()
    frames = [hub.Image(convert_animation_frame(frame, brightness)) for frame in g_animation]
    vm.system.display.show(frames, clear=False, delay=500, loop=True, fade=4)
    await vm.system.sound.play_async("/extra_files/Initialize", freq=pitch_to_freq(vm.store.sound_pitch(), 12000, 16000, 20000))
    await dogBotSetSpeed(vm, 80)
    await dogBotWalkForSeconds(vm, "forward", 10)

def setup(rpc, system, stop):
    vm = VirtualMachine(rpc, system, stop, "9keTUnADhNGrFtnukJB2")

    vm.register_on_start("A_THgQjxe9OSHpY8xtlS", stack_1)

    return vm
