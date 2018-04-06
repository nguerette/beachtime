
CF_APP_NAME := prerequisite
ENV_FILE := beachtime-env.sh
ENVVAR_SECRET_KEY := DJANGO_SECRET_KEY

run:
	source $(ENV_FILE); ./manage.py runserver

cf:
	source $(ENV_FILE); cf set-env $(CF_APP_NAME) $(ENVVAR_SECRET_KEY) $$$(ENVVAR_SECRET_KEY)
	cf push $(CF_APP_NAME) -c 'python manage.py migrate && gunicorn beachtime.wsgi --log-file -'
