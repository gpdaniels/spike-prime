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

#include "log.hpp"

#include <android/log.h>

#include <cstdarg>
#include <cstdio>

#define LOG_TAG "controller"

int log(log_level level, const char* format, ...) {
    
    int output = 0;
    
    va_list format_arguments;
    va_start(format_arguments, format);
    switch (level) {
        case log_level::verbose: {
            output = __android_log_print(ANDROID_LOG_VERBOSE, LOG_TAG, format, format_arguments);
        } break;
        case log_level::debug: {
             output = __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, format, format_arguments);
        } break;
        case log_level::information: {
            output = __android_log_print(ANDROID_LOG_INFO, LOG_TAG, format, format_arguments);
        } break;
        case log_level::warning: {
            output = __android_log_print(ANDROID_LOG_WARN, LOG_TAG, format, format_arguments);
        } break;
        case log_level::error: {
            output = __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, format, format_arguments);
        } break;
        case log_level::fatal: {
            output = __android_log_print(ANDROID_LOG_FATAL, LOG_TAG, format, format_arguments);
        } break;
    }
    va_end(format_arguments);
    
    return output;
}
