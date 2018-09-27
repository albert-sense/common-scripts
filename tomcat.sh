#!/bin/bash

echo "Current user is $USER ...";

webName=passport
webPort=8080
TOMCAT_HOME=/usr/local/tomcats/apache-tomcat-8.0.39
export CATALINA_BASE=/data/web/${webName}
export CATALINA_PID=/data/web/${webName}/temp/catalina.pid

if [ "$1" = "start" ];then
        echo "start ${webName}  [port:${webPort}] service ...";
        cd $TOMCAT_HOME/bin
        ./startup.sh
        echo "start ${webName}  [port:${webPort}] service successful ...";

elif [ "$1" = "stop" ];then
        echo "stop ${webName}  [port:${webPort}] service ...";
        cd $TOMCAT_HOME/bin
        ./shutdown.sh
        if [ -f "$CATALINA_BASE/temp/catalina.pid" ]; then
                cat $CATALINA_BASE/temp/catalina.pid | xargs kill -9
                rm -f $CATALINA_BASE/temp/catalina.pid
        fi
        echo "stop ${webName}  [port:${webPort}]  service successful ...";

elif [ "$1" = "restart" ];then
        echo "stop ${webName}  [port:${webPort}] service ...";
        cd $TOMCAT_HOME/bin
        ./shutdown.sh
        if [ -f "$CATALINA_BASE/temp/catalina.pid" ]; then
                cat $CATALINA_BASE/temp/catalina.pid | xargs kill -9
                rm -f $CATALINA_BASE/temp/catalina.pid
        fi
        sleep 5
        ./startup.sh
        echo "restart ${webName}  [port:${webPort}] service successful ...";

else
        echo "usage:$0 start|stop|restart";
fi
