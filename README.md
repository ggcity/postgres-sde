Docker PostgreSQL instance with PostGIS & Esri ArcSDE enabled
================

USAGE
----------------
* This build includes Postgres version 9.5.7 with PostGIS version 2.2. 

* This build does not include .so files as they are proprietary to Esri. These files are included with installation of ArcDesktop or ArcServer. See Esri's support site for instructions to setup licensing for your agency.

* After cloning this repository, obtain and activate .so files from Esri & place all 3 .so files in the `esri/` directory

* To change the default database name, edit the `ENV POSTGRES_DB` parameter in the Dockerfile

* If you want to add proprietary Esri projections, add them to the `initdb/2_insert_esri_srids.sql` file. Any .sh or .sql files placed in this directory will be run on docker build.

Run the following commands to initialize the Docker instance using the container psql:

    $ docker build -t postgres-sde . 
    $ docker run --name=postgres-sde-1 --rm -d postgres-sde
    $ docker run --link postgres-sde-1:postgres-sde-2 --rm -ti postgres-sde psql -h postgres-sde-2 sde -U postgres

To run psql via your local psql install:

    $ docker build -t postgres-sde . 
    $ docker run --name=postgres-sde-1 --rm -d -p 15432:5432 postgres-sde
    $ psql -h localhost -p 15432 sde -U postgres 

See [Docker documentation](https://hub.docker.com/_/postgres/) if you would like to extend your container to mount a persistent data directory, add data, etc.


LICENSE
----------------

    Copyright (C) 2017  City of Garden Grove

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
