"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub
import utime

from .settings import Sounds


frame1 = hub.Image("00000:00000:09000:00000:00000")
frame2 = hub.Image("00000:00000:07000:00000:00000")
frame3 = hub.Image("00000:00000:07000:00009:00000")
frame4 = hub.Image("00000:00000:07000:00007:00000")
frame5 = hub.Image("00000:00000:07000:90007:00000")
frame6 = hub.Image("00000:00000:07000:70007:00000")
frame7 = hub.Image("00000:90000:07000:70007:00000")
frame8 = hub.Image("00000:70000:07000:70007:00000")
frame9 = hub.Image("00000:70000:07000:70007:00900")
frame10 = hub.Image("00000:70000:07000:70007:00700")
frame11 = hub.Image("00000:70900:07000:70007:00700")
frame12 = hub.Image("00090:70800:07000:70007:00700")
frame13 = hub.Image("00080:70800:07000:79007:00700")
frame14 = hub.Image("00080:70700:07090:78007:00700")
frame15 = hub.Image("00070:70700:07080:78007:90700")
frame16 = hub.Image("09070:70700:07070:77007:80700")
frame17 = hub.Image("08070:70700:07070:77007:80709")
frame18 = hub.Image("08079:70700:07070:77007:70708")
frame19 = hub.Image("07078:70700:07070:77907:70708")
frame20 = hub.Image("07078:79700:07070:77707:70707")
frame21 = hub.Image("07077:78700:07079:77707:70707")
frame22 = hub.Image("07077:78700:07078:77707:79707")
frame23 = hub.Image("07977:78700:07078:77707:78707")
frame24 = hub.Image("07877:77700:07078:77797:78707")
frame25 = hub.Image("07877:77709:07077:77787:78707")
frame26 = hub.Image("07877:77708:97077:77787:77707")
frame27 = hub.Image("07777:77708:87077:77787:77797")
frame28 = hub.Image("07777:77798:87077:77777:77787")
frame29 = hub.Image("97777:77787:87077:77777:77787")
frame30 = hub.Image("87777:77787:87977:77777:77787")
frame31 = hub.Image("99999:99999:99999:99999:99999")
frame32 = hub.Image("77777:77777:77777:77777:77777")
frame40 = hub.Image("66669:66669:66669:66669:66669")
frame41 = hub.Image("55599:55595:55595:55595:55599")
frame42 = hub.Image("44999:44949:44949:44949:44999")
frame43 = hub.Image("39993:39393:39393:39393:39993")
frame44 = hub.Image("09990:09090:09090:09090:09990")


def bootup_animation():
    for pct in range(100, 0, -10):
        hub.led(
            int(0 * (pct / 100)),
            int(0 * (pct / 100)),
            int(80 * (pct / 100)),
        )
        utime.sleep_ms(30)

    hub.led(0, 0, 0)

    # Phase 1
    hub.sound.play(Sounds.STARTUP, 16000)
    hub.display.show(frame1, fade=2, delay=25)
    hub.display.show(frame2, fade=2, delay=82)
    utime.sleep_ms(160)
    hub.display.show(frame3, fade=2, delay=15)
    hub.display.show(frame4, fade=2, delay=64)
    utime.sleep_ms(140)
    hub.display.show(frame5, fade=2, delay=9)
    hub.display.show(frame6, fade=2, delay=49)
    utime.sleep_ms(110)
    hub.display.show(frame7, fade=2, delay=6)
    hub.display.show(frame8, fade=2, delay=52)
    hub.display.show(frame9, fade=2, delay=4)
    hub.display.show(frame10, fade=2, delay=45)
    hub.display.show(frame11, fade=2, delay=41)

    # Phase 2
    utime.sleep_ms(80)
    hub.display.show(frame12, fade=2, delay=37)
    hub.display.show(frame13, fade=2, delay=34)
    hub.display.show(frame14, fade=2, delay=31)
    hub.display.show(frame15, fade=2, delay=29)
    hub.display.show(frame16, fade=2, delay=27)
    utime.sleep_ms(60)
    hub.display.show(frame17, fade=2, delay=25)
    hub.display.show(frame18, fade=2, delay=23)
    hub.display.show(frame19, fade=2, delay=21)
    hub.display.show(frame20, fade=2, delay=19)
    hub.display.show(frame21, fade=2, delay=17)
    hub.display.show(frame22, fade=2, delay=15)
    utime.sleep_ms(60)
    hub.display.show(frame23, fade=2, delay=14)
    hub.display.show(frame24, fade=2, delay=13)
    hub.display.show(frame25, fade=2, delay=12)
    hub.display.show(frame26, fade=2, delay=11)
    hub.display.show(frame27, fade=2, delay=10)
    utime.sleep_ms(50)
    hub.display.show(frame28, fade=2, delay=9)
    hub.display.show(frame29, fade=2, delay=8)
    hub.display.show(frame30, fade=2, delay=8)
    utime.sleep_ms(20)
    hub.display.show(frame31, fade=2, delay=200)
    utime.sleep_ms(15)
    hub.display.show(hub.Image.HEART, fade=2, wait=True, delay=500)


frames = [
    hub.Image("99999:90009:90009:90009:99999"),
    hub.Image("55555:57775:57075:57775:55555"),
    hub.Image("00000:09990:09090:09990:00000"),
    hub.Image("00000:05550:05750:05550:00000"),
    hub.Image("00000:00000:00900:00000:00000"),
    hub.Image("00000:00000:00500:00000:00000"),
    hub.Image("00000:00000:00000:00000:00000")
]


def shutdown_animation():
    hub.display.show(frames, fade=2, wait=False, delay=40)

