mkdir ~/.ssh
touch ~/.ssh/known_hosts
ssh-keyscan -H 172.17.0.2 >> ~/.ssh/known_hosts