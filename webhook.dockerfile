FROM nginx
WORKDIR /
ADD ./app/docker/note_templates/templates.json /var/share/nginx/html/note_templates
EXPOSE 9902
