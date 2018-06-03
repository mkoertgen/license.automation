FROM licensefinder/license_finder:5.2.3

# TODO: add nuget

# TODO: labels?

### app
COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt

COPY . /app

EXPOSE 5000

CMD [ "python", "app.py" ]