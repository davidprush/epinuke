#!/bin/bash
echo "Numebr of args: $#"
echo "$@"
echo "$(echo "$@" | grep ' ' | tr '\r ' '\n' | grep "/")"
