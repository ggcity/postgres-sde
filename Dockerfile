FROM postgres:9.5.7

RUN dpkg-divert --local --rename --add /sbin/initctl
# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
# Add PostgreSQL's repository. It contains the most recent stable release of PostgreSQL 9.5
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get -y update
RUN apt-get -y install ca-certificates rpl pwgen
RUN apt-get install -y postgresql-9.5-postgis-2.2

# If mounting a persistent data directory, uncomment line below
#VOLUME /var/lib/postgresql/data

# Set the default database name (will be created automatically)
ENV POSTGRES_DB sde

# Copy Esri .so files into container image
COPY esri/libst_raster_pg.so /usr/lib/postgresql/9.5/lib/
COPY esri/PGSQLEngine.so /usr/lib/postgresql/9.5/lib/
COPY esri/st_geometry.so /usr/lib/postgresql/9.5/lib/
# Run any .sh or .sql files in the initdb directory
COPY initdb/* /docker-entrypoint-initdb.d/

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]
