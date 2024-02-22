#!/bin/bash
(echo "";) | /opt/gitlab/embedded/bin/runsvdir-start & > /dev/null
gitlab-ctl reconfigure
gitlab-ctl start
/home/onece-exec run --path='/home/gitlab-inited.txt' --onece='sh /home/init.sh'
gitlab-ctl restart
service ssh start
gitlab-runner start
tail -f /opt/gitlab/embedded/service/gitlab-rails/log/production.log
