#!/bin/sh
current_branch=`git branch | grep '*' | sed 's/* //'`

if [ "$current_branch" = "master" ] || [ "$current_branch" = "main" ]; then
    echo "You are about to commit on master. I will run your unittest tests first..."
    python -m pytest
    if [ $? -eq 0 ]; then
        # tests passed, proceed to prepare commit message
        exit 0
    else
        # some tests failed, prevent from committing broken code on master
        echo "Some tests failed. You are not allowed to commit broken code on master! Aborting the commit."
        echo "Note: you can still commit broken code on feature branches"
        exit 1
    fi
fi