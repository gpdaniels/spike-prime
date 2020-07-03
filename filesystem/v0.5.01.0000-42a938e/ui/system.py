"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import uasyncio.core as asyncio


loop = asyncio.get_event_loop(len=100)
sleep = asyncio.sleep
sleep_ms = asyncio.sleep_ms


def call_soon(coro):
    loop.call_soon(coro)
    return coro


def cancel(coro):
    try:
        coro.close()
    except ValueError:
        pass

    try:
        asyncio.cancel(coro)
    except:
        pass

