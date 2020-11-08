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

#include "main.hpp"

#include "application.hpp"
#include "log.hpp"

#include <android_native_app_glue.h>

extern "C" void android_main(android_app* state) {
    LOGI("Initialising...");

    // Check for permissions.
    // TODO: Check for permissions.

    // Construct the application.
    application app;

    // Attempt to restore the application state.
    app.restore(state);

    // Setup pointer back to the application class for callbacks.
    state->userData = &app;

    // Setup the callback functions.
    state->onAppCmd = [](android_app* state, int32_t cmd)->void {
        // Extract the application class instance.
        application* app = reinterpret_cast<application*>(state->userData);
        // Attempt to pass the call to the application.
        if (app != nullptr) {
            app->onAppCmd(state, cmd);
        }
    };

    state->onInputEvent = [](android_app* state, AInputEvent* event)->int32_t {
        // Extract the application class instance.
        application* app = reinterpret_cast<application*>(state->userData);
        // Attempt to pass the call to the application.
        if (app != nullptr) {
            return app->onInputEvent(state, event);
        }
        return 0;
    };

    // Save the javaVM.
    //state->activity->vm

    // Main application loop.
    LOGI("Starting main application loop...");
    bool running = true;
    while (running) {
        // Process all user input.
        android_poll_source* source;
        int events;
        // If not visible this poll will block forever, if visible it will not block to ensure fast rendering.
        while (ALooper_pollAll(((app.is_focused()) ? 0 : -1), nullptr, &events, reinterpret_cast<void**>(&source)) >= 0) {
            // Process the received event.
            if (source != nullptr) {
                source->process(state, source);
            }
            // Check if the application is closing.
            if (state->destroyRequested != 0) {
                running = false;
                break;
            }
        }

        // Draw a frame if the window is visible.
        if (app.is_focused()) {
            app.render(state);
        }
    }

    LOGI("Finished main application loop.");
}