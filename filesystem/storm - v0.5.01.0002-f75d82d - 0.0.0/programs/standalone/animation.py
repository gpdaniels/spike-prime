"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
from ui.system import call_soon, cancel, sleep_ms


def reverse_image(image):
    """
    Reverse an image horizontally.

    :param [int] image: Image to reverse
    :return [int]: Reversed image
    """
    return tuple(reversed(image))


def reverse_animation(images):
    """
    Reverse all images in an animation horizontally, and reverses the
    sequence of images in backwards order.

    :param [image] images: An iterator of images
    :return [image]: Reverted images in reverse order
    """
    return tuple(reverse_image(image) for image in images)


class AnimationController(object):
    """

    """
    def __init__(self, display):
        self.display = display
        self.runner = None
        self.animation = None
        self.current = 0

    def start(self, animation, delay=0):
        """
        Start a new animation.

        :param Animation animation: The animation to run
        :param int delay: The delay in milliseconds before animating
        """
        self.stop()
        self.animation = animation
        self.animation._running = True
        self.runner = self._run_animation(
            animation, delay, self.current)
        call_soon(self.runner)

    def stop(self):
        """
        Stop the current running animation (if any).
        """
        self.current += 1
        if self.animation:
            self.animation._running = False
        if self.runner:
            cancel(self.runner)
            self.runner = None

    async def _run_animation(self, animation, delay, current):
        if delay:
            try:
                await sleep_ms(delay)
            except AttributeError:
                # uasyncio bug resulting in AttributeError when cancelled
                animation._running = False
                return

        for image in animation:
            if current != self.current:
                break

            self.display.draw(*image)

            try:
                await sleep_ms(animation.sleep)
            except AttributeError:
                # uasyncio bug resulting in AttributeError when cancelled
                animation._running = False
                return

        animation._running = False


class Animation(object):
    """
    Represents a single animation.

    Animations consists of a sequence of images. Images consists of a number
    of pixels, defined from left to right. Each image must adhere to the
    parameters of DisplayController.draw().

    For instance, the following sequence defined an image where the
    right-most pixels on the display are drawn:

        (None, 9, 6, 9, 6)

    An example of an image sequence is:

        (
            (9, 0, 0, 0, 0),
            (0, 9, 0, 0, 0),
            (0, 0, 9, 0, 0),
            (0, 0, 0, 9, 0),
            (0, 0, 0, 0, 9),
        )

    An example of looping through the images of an animation:

        for image in animation:
            ...

    """
    def __init__(self, images, loop=False, sleep=50):
        self._images_original = tuple(images)
        self._next_index = 0
        self._running = False
        self.images = tuple(images)
        self.loop = loop
        self.sleep = sleep

    def __iter__(self):
        if self.loop:
            return self.loop_images_infinitely()
        else:
            return iter(self.images)

    def loop_images_infinitely(self):
        """
        Creates an infinite iterator of images.
        """
        while 1:
            index = self._next_index % len(self.images)
            self._next_index += 1
            yield self.images[index]

    def is_running(self):
        """
        Check whether the animation is currently running.

        :return bool: Animation is running
        """
        return self._running

    def reset(self):
        """
        Reset the animation to its beginning.
        """
        self._next_index = 0

    def forward(self):
        """
        Make the animation run forward.
        """
        self.images = self._images_original

    def backward(self):
        """
        Make the animation run backward.
        """
        self.images = reverse_animation(self._images_original)


class SingleSensorAnimation(Animation):
    def __init__(self):
        super(SingleSensorAnimation, self).__init__(
            loop=True,
            sleep=200,
            images=(
                (9, 0, 0, 0, 0),
                (9, 9, 0, 0, 0),
                (9, 0, 9, 0, 0),
                (9, 0, 0, 9, 0),
                (9, 0, 0, 0, 9),
            ),
        )


class SingleActuatorAnimation(Animation):
    def __init__(self):
        super(SingleActuatorAnimation, self).__init__(
            loop=True,
            sleep=200,
            images=(
                (None, 0, 0, 0, 9),
                (None, 0, 0, 9, 0),
                (None, 0, 9, 0, 0),
                (None, 9, 0, 0, 0),
                (None, 0, 0, 0, 0),
            ),
        )


class SensorActuatorAnimation(Animation):
    def __init__(self):
        super(SensorActuatorAnimation, self).__init__(
            sleep=60,
            images=(
                (7, 9, 9, 9, 9),
                (9, 7, 9, 9, 9),
                (9, 9, 7, 9, 9),
                (9, 9, 9, 7, 9),
                (9, 9, 9, 9, 7),
                (9, 9, 9, 9, 9),
            ),
        )
