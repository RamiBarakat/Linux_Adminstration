#!/bin/bash

var=$(who | awk '{ print $3, $4, "-" , $1 }')
echo $var
