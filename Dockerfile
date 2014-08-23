FROM densuke/supervisor:latest

ENV nginx development
ENV dist trusty
RUN echo "deb http://ppa.launchpad.net/nginx/$nginx/ubuntu $dist main" > /etc/apt/sources.list.d/nginx-$nginx-$dist.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
RUN apt-get update 
RUN apt-get install -y nginx php5-fpm
RUN apt-get autoremove -y
RUN apt-get clean
RUN mkdir /var/www && chown -R www-data.www-data /var/www
ADD nginx.ini /etc/supervisord.d/
ADD php5-fpm.ini /etc/supervisord.d/
ADD php.ini /etc/php5/fpm/
ADD default /etc/nginx/sites-available/

CMD ["/usr/local/bin/supervisord", "-n"]
