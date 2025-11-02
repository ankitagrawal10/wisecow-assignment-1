# Use Ubuntu as base image
FROM ubuntu:20.04


RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf \
    && apt-get update \
    && apt-get install -y \
       fortune-mod \
       cowsay \
       netcat \
    && rm -rf /var/lib/apt/lists/* # REMOVED: && rm /etc/resolv.conf

# Copy the wisecow script

COPY wisecow.sh /usr/local/bin/wisecow.sh

# Make it executable and ensure Unix line endings
RUN chmod +x /usr/local/bin/wisecow.sh \
 @   && sed -i 's/\r$//' /usr/local/bin/wisecow.sh


# Ensure fortune and cowsay are on PATH (they are installed to /usr/games on Ubuntu)
# The checks are good practice.
RUN if [ -x /usr/games/fortune ] && [ ! -x /usr/local/bin/fortune ]; then ln -s /usr/games/fortune /usr/local/bin/fortune; fi \
    && if [ -x /usr/games/cowsay ] && [ ! -x /usr/local/bin/cowsay ]; then ln -s /usr/games/cowsay /usr/local/bin/cowsay; fi


EXPOSE 4499


CMD ["./usr/local/bin/wisecow.sh"]
