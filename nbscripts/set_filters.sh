#!/bin/bash

git config filter.notebooks.clean nbscripts/strip_nb_output.py
git config filter.notebooks.smudge cat

