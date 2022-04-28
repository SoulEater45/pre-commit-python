#!/bin/sh

# Credit goes to Giacomo Debidda (2022-04-28)
# Source: https://www.giacomodebidda.com/posts/a-simple-git-hook-for-your-python-projects/

current_branch=`git branch | grep '*' | sed 's/* //'`

if [ "$current_branch" = "master" ]; then
    echo "You are about to commit on master. I will run your tests first..."
    python -m unittest discover tests
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