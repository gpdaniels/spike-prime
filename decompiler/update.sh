#!/bin/sh
if ls $1 2>/dev/null >/dev/null; then
    ts-node -T decompile.ts $1
else
    echo 'Usage: <path/to/src>'
fi