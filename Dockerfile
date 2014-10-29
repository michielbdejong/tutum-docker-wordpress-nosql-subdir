FROM tutum/apache-php:latest
MAINTAINER Borja Burgos <borja@tutum.co>, Feng Honglin <hfeng@tutum.co>

# Install packages
RUN apt-get update && \
  apt-get -yq install mysql-client && \
  rm -rf /var/lib/apt/lists/*

# Download latest version of Wordpress into /wordpress
# and make that a symlinked subdir of /app

RUN rm -fr /app
ADD WordPress/ /wordpress
ADD wp-config.php /wordpress/wp-config.php
RUN chown www-data:www-data /app -R
RUN chown www-data:www-data /wordpress -R
RUN echo "see <a href=\"wordpress/\">wordpress/</a>" > /app/index.html
RUN ln -s /wordpress /app/wordpress

# Add script to create 'wordpress' DB
ADD run-wordpress.sh /run-wordpress.sh
RUN chmod 755 /*.sh

# Modify permissions to allow plugin upload
RUN chmod -R 777 /app/wordpress/wp-content

# Expose environment variables
ENV DB_HOST **LinkMe**
ENV DB_PORT **LinkMe**
ENV DB_NAME wordpress
ENV DB_USER admin
ENV DB_PASS **ChangeMe**

EXPOSE 80
VOLUME ["/app", "/wordpress/wp-content"]
CMD ["/run-wordpress.sh"]
