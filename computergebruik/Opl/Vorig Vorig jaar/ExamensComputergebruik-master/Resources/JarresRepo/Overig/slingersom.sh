#!/bin/bash
seq -s "" $1 | sed -r 's/([0-9])([0-9])/\1-\2+/g' | sed 's/.*/echo $((&))/' | bash

