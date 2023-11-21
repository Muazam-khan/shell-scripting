#!/bin/bash

# This is a single line comment

# Below is an example of multi line comment

<<COMMENT  #cap letter here is not important, u can use anyword instead of comment here, << is comment syntax here
echo "Cloud DEVOPS Training"
echo "Shell Scripting"
a=100
b=300
echo $a

echo $b
COMMENT
echo "Value of b is $b"