#!/usr/bin/env bash
# WARNING -> THIS FILE IS MAINTAINED BY puppetmaster

<% if @operatingsystem.match("RedHat") %>
oraPATH=`ps -ef|grep tnslsnr|awk {'print $8'}|grep bin|sed 's!/tnslsnr!!g'`
<% elsif @operatingsystem.match("Solaris") %>
oraPATH=`ps -ef|grep tnslsnr|awk {'print $9'}|grep bin|sed 's!/tnslsnr!!g'`
<% end -%>
oraHOME=`echo $oraPATH|sed 's!bin!!g'`
export ORACLE_HOME=$oraHOME
oraVER=`$oraPATH/sqlplus -V|awk {'print $3'}|grep -v '^$'`
echo $oraVER