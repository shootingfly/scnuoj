#!/usr/bin/env_bash
kill -9 `cat tmp/pids/resque.id`
rake resque:work QUEUE='*' PIDFILE='tmp/pids/resque.id' BACKGROUND=yes
rake log:clear
