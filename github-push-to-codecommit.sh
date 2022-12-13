#!/usr/bin/env sh

set -eu  # Exit script on error

echo "### Configure SSH"

echo "# Create default .ssh path, if not exists"
mkdir -p ~/.ssh
echo "# Set .ssh permissions"
chmod 700 ~/.ssh

echo "# Create SSH private key"
echo "$SSH_DEPLOY_KEY" > ~/.ssh/id_rsa
echo "# Set ~/.ssh/id_rsa permissions"
chmod 600 ~/.ssh/id_rsa

echo "# Add host in ssh know_hosts"
ssh-keyscan -H $CODECOMMIT_HOST > ~/.ssh/known_hosts
echo "# Set ~/.ssh/known_hosts permissions"
chmod 600 ~/.ssh/known_hosts

echo "# create SSH config file"
cat >~/.ssh/config <<END
Host $CODECOMMIT_HOST
    User $SSH_KEY_ID
    IdentityFile ~/.ssh/id_rsa
END

echo "# Listing created files"
ls -ald ~/.ssh
ls -al ~/.ssh

echo "### Test ssh"
echo $(ssh $SSH_KEY_ID@$CODECOMMIT_HOST)

echo "### Add remote"
git remote add codecommit $CODECOMMIT_REPO

echo "### Push code - git push -u codecommit $LOCAL_BRANCH_NAME:$REMOTE_BRANCH_NAME"
git push -f -u codecommit $LOCAL_BRANCH_NAME:$REMOTE_BRANCH_NAME