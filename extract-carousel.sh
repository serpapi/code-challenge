#!/bin/sh
if [ $# -eq 0 ]; then
    echo
    echo " Usage: $0 <FILE>"
    echo
    echo " Displays the carousel data from a Google search result in the standard output as JSON."
    echo
    echo " Arguments:"
    echo
    echo "   FILE: path to a file containing the HTML of a Google search result"
    echo
    echo " Example:"
    echo
    echo " $0 ./samples/van-gogh-paintings.html"
    echo
    echo
    exit 1
fi
cat $1 | deno run ./index.js
