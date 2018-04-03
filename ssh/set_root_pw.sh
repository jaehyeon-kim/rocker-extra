#!/bin/bash

echo "=> Adding SSH key to /home/rstudio/"
mkdir -p /home/rstudio/.ssh \
    && chmod go-rwx /home/rstudio/.ssh \
    && cat /home/rstudio/pub/id_rsa.pub >> /home/rstudio/.ssh/authorized_keys
chmod go-rw /home/rstudio/.ssh/authorized_keys
echo "=> Done!"
chown -R rstudio:rstudio /home/rstudio/.ssh

echo "========================================================================"
echo "You can now connect to this container via SSH using:"
echo ""
echo "    ssh -p <port> <user>@<host>"
echo ""
echo "Only rstudio user exists (staff group and sudoer)."
echo "========================================================================"
