/*
The MIT License
Copyright (c) 2020 Geoffrey Daniels. http://gpdaniels.com/
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE
*/

#include "application.hpp"

#include "log.hpp"

#include <android_native_app_glue.h>
#include <malloc.h>

bool application::is_focused() const {
    return this->focused;
}

void application::save(android_app* state) const {
    // If there is already an old saved state, clean it up.
    if (state->savedState != nullptr) {

        free(state->savedState);
        state->savedState = nullptr;
        state->savedStateSize = 0;
    }

    // Now save the current state in a binary blob.
    // NOTE: The android_native_app_glue handles freeing this buffer.
    //state->savedStateSize = ??;
    //state->savedState = malloc(state->savedStateSize)
}

void application::restore(android_app* state) {
    if (state->savedState == nullptr) {
        LOGW("Attempted to restore an empty state.");
        return;
    }

    // Restore state from the provided binary blob.
    //state->savedState;
    //state->savedStateSize;
}

void application::onAppCmd(android_app* state, int32_t cmd) {
    switch (cmd) {
        case APP_CMD_SAVE_STATE: {
            LOGI("Saving application state...");
            this->save(state);
        } break;
        case APP_CMD_INIT_WINDOW: {
            LOGI("Initialising window...");
            // Upon window init ensure its buffer is RGBA 8888 format.
            if (state->window != nullptr) {
                // Store the initial format to reset it upon exit.
                this->format_previous = ANativeWindow_getFormat(state->window);
                // Set the window format to RGBA 8888 for easy rendering.
                ANativeWindow_setBuffersGeometry(state->window, ANativeWindow_getWidth(state->window), ANativeWindow_getHeight(state->window), WINDOW_FORMAT_RGBA_8888);
                // Do a draw to make sure the content is valid.
                this->render(state);
            }
        } break;
        case APP_CMD_TERM_WINDOW: {
            LOGI("Terminating window...");
            this->focused = false;
            if (state->window != nullptr) {
                // Reset the format to its initial value.
                ANativeWindow_setBuffersGeometry(state->window, ANativeWindow_getWidth(state->window), ANativeWindow_getHeight(state->window), this->format_previous);
                this->format_previous = 0;
            }
        } break;
        case APP_CMD_GAINED_FOCUS: {
            LOGI("Window gained focus.");
            this->focused = true;
        } break;
        case APP_CMD_LOST_FOCUS: {
            LOGI("Window lost focus.");
            this->focused = false;
        } break;

        case APP_CMD_WINDOW_RESIZED:        { LOGI("Window resized."); } break;
        case APP_CMD_WINDOW_REDRAW_NEEDED:  { LOGI("Window redraw requested."); } break;
        case APP_CMD_CONTENT_RECT_CHANGED:  { LOGI("Window content rectangle changed."); } break;
        case APP_CMD_CONFIG_CHANGED:        { LOGI("Configuration changed."); } break;
        case APP_CMD_LOW_MEMORY:            { LOGI("Low memory."); } break;
        case APP_CMD_INPUT_CHANGED:         { LOGI("Input changed."); } break;
        case APP_CMD_START:                 { LOGI("Starting..."); } break;
        case APP_CMD_RESUME:                { LOGI("Resuming..."); } break;
        case APP_CMD_PAUSE:                 { LOGI("Pausing..."); } break;
        case APP_CMD_STOP:                  { LOGI("Stopping..."); } break;
        case APP_CMD_DESTROY:               { LOGI("Destroying..."); } break;

        default: {
            LOGI("Unknown cmd: cmd=%d", cmd);
        } break;
    }
}

int32_t application::onInputEvent(android_app* state, AInputEvent* event) {
    switch (AInputEvent_getType(event)) {
        case AINPUT_EVENT_TYPE_MOTION: {
            LOGI("Touch event: action=%d metaState=0x%x", AKeyEvent_getAction(event), AKeyEvent_getMetaState(event));
            size_t pointerCount = AMotionEvent_getPointerCount(event);
            for (size_t i = 0; i < pointerCount; ++i) {
                LOGI("  Received motion event from pointer %zu: (%.2f, %.2f)",i, AMotionEvent_getX(event, i), AMotionEvent_getY(event, i));
            }
        } break;
        case AINPUT_EVENT_TYPE_KEY: {
            LOGI("Key event: action=%d keyCode=%d metaState=0x%x", AKeyEvent_getAction(event), AKeyEvent_getKeyCode(event), AKeyEvent_getMetaState(event));
        } break;
        default: {
            LOGI("Unknown event: action=%d metaState=0x%x", AKeyEvent_getAction(event), AKeyEvent_getMetaState(event));
        } break;
    }

    return 0;
}

void application::render(android_app* state) const {
    if (state->window == nullptr) {
        LOGW("Attempted to render without a window.");
        return;
    }

    ANativeWindow_Buffer buffer;
    if (ANativeWindow_lock(state->window, &buffer, nullptr) < 0) {
        LOGE("Unable to lock window buffer.");
        return;
    }

    //LOGI("width=%d height=%d stride=%d format=%d", buffer.width, buffer.height, buffer.stride, buffer.format);

    static int call = 0;
    call++;

    void* pixels = buffer.bits;
    for (unsigned int yy = 0; yy < buffer.height; yy++) {
        unsigned int* line = reinterpret_cast<unsigned int*>(pixels);
        for (unsigned int xx = 0; xx < buffer.width; xx++) {
            line[xx] = (
                (((yy + call/10) % 255u) << 24u) |
                (((xx - call/10) % 255u) << 16u) |
                (((yy + xx * call/10) % 255u) << 8u) |
                (((yy * call/10 - xx) % 255u) << 0u)
            );
        }
        // Go to next line
        pixels = reinterpret_cast<uint32_t*>(pixels) + buffer.stride;
    }

    if (ANativeWindow_unlockAndPost(state->window) < 0) {
        LOGE("Unable to unlock and post window buffer.");
    }
}
