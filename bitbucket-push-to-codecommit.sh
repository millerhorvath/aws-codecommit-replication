#!/usr/bin/env sh

set -eu  # Exit script on error

echo "Host $CODECOMMIT_HOST" >> ~/.ssh/config  # Set host on ssh config file
echo "User $SSH_KEY_ID" >> ~/.ssh/config  # Set user on ssh config file
git remote add codecommit $CODECOMMIT_REPO  # Add CodeCommit repo as git remote
git push -u codecommit $BITBUCKET_BRANCH:$REMOTE_BRANCH_NAME  # Push source branch into the predefined CodeCommit repo branch