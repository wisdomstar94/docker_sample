#!/bin/bash

# root-password-change
if [ -n "$ROOT_PASSWORD" ]
then
  (echo "user = User.where(id: 1).first"; \
  echo "user.password='$ROOT_PASSWORD'"; \
  echo "user.password_confirmation='$ROOT_PASSWORD'"; \
  echo "user.save"; \
  echo "exit";) | gitlab-rails console -e production
else
  echo "ROOT_PASSWORD 환경변수가 없으므로 수행되지 않음." 
fi

# # node.js setting
# nvm install v20.11.1 
# nvm use 20.11.1 
# nvm alias default 20.11.1