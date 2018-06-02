#FROM python:2.7.15-alpine3.7
FROM python:2.7.15-stretch

# TODO: labels?

#ARG DEPS="gcc musl-dev linux-headers libxml2-dev libxslt-dev g++ git"
#RUN apk add --update ${DEPS} && rm -rf /var/cache/apk/* \
#  && mkdir -p /usr/include/libxml \
#  && ln -s /usr/include/libxml2/libxml/xmlexports.h /usr/include/libxml/xmlexports.h \
#  && ln -s /usr/include/libxml2/libxml/xmlversion.h /usr/include/libxml/xmlversion.h

COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt

COPY . /app

EXPOSE 5000

CMD [ "python", "app.py" ]