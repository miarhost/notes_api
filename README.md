* docker-compose up --build -d
Runs from docker, can be tested from web container shell.
For example
* docker exec -it <container-name>
-for database container:
* mysql -uroot -p -A
create database <database-name>;
- for web:
rails db:migrate
rails c
