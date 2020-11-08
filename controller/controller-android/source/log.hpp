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

#pragma once
#ifndef LOG_HPP
#define LOG_HPP

enum class log_level {
    verbose,
    debug,
    information,
    warning,
    error,
    fatal
};

int log(log_level level, const char* format, ...);

#if defined(NDEBUG)
    #define LOGV(...)
    #define LOGD(...)
    #define LOGI(...)
    #define LOGW(...)
    #define LOGE(...)
    #define LOGF(...)
#else
    #define LOGV(...) log(log_level::verbose, __VA_ARGS__)
    #define LOGD(...) log(log_level::debug, __VA_ARGS__)
    #define LOGI(...) log(log_level::information, __VA_ARGS__)
    #define LOGW(...) log(log_level::warning, __VA_ARGS__)
    #define LOGE(...) log(log_level::error, __VA_ARGS__)
    #define LOGF(...) log(log_level::fatal, __VA_ARGS__)
#endif

#endif // LOG_HPP
