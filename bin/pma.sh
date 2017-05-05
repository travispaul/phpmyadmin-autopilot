#!/bin/bash
exec supervisord --nodaemon --configuration="/etc/supervisord.conf" --loglevel=info