docker-reviewboard
==================
Forked from ikatson/docker-reviewboard and adapted to work with apache and mysql.

Dockerized reviewboard. This container follows Docker's best practices, and DOES NOT include sshd, supervisor, apache2, or any other services except the reviewboard itself which is run with ```uwsgi```.

## Quickstart. Run dockerized reviewboard with all dockerized dependencies, and persistent data in a docker container.

    # Setup a MySQL container
    docker run --name review-board-mysql --restart=always -e MYSQL_ROOT_PASSWORD=<your_pwd> -d mysql:latest
    
    # Setup the RB database
    docker exec -it review-board-mysql bash
    mysql -uroot -p
    <enter pwd>
    sql> create database <RB_database_name>;
    exit
    exit

    # Install memcached
    ddocker run --name review-board-memcached --restart=always -d memcached memcached -m 4048

    # Create a data container for reviewboard with ssh credentials and media.
    docker run -v /.ssh -v /media --name rb-data busybox true
    
    # Create a container to run HTTPD
    docker run -it --restart=always --name review-board-apache -v <some_httpd_data_location>:/usr/local/apache2/htdocs/ httpd:2.4
    
    # Run reviewboard
    docker run -it --link review-board-mysql:mysql --link review-board-memcached:memcached --link review-board-httpd:httpd --volumes-from rb-data --name review-board -v <location_that_httpd_uses>:/var/www -p 8000:8000 -e MYSQL_HOST="<ip_of_mysql_container>" -e MYSQL_USER="root" -e MYSQL_PASSWORD="<mysql_root_pwd>" -e MYSQL_DATABASE="<RB_db_name>" -e ADMIN_PASSWORD="<RB_admin_passwd>" -e ADMIN_EMAIL="<RB_admin_email>" -e DOMAIN="<RB_domain_name>" feetball/reviewboard

After that, go the url, e.g. ```http://localhost:8000/```, login as ```admin:<RB_admin_pwd>```, change the admin password, and change the location of your SMTP server so that the reviewboard can send emails. You are all set!
