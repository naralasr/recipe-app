FROM python:3.8-slim
LABEL maintainer="SunilReddy"
ENV PYTHONUNBUFFERED 1

COPY ./app /app
WORKDIR /app
EXPOSE 8000

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

ARG DEV=false

RUN python -m venv /env && \
    /env/bin/pip install --upgrade pip && \
    /env/bin/pip install -r /tmp/requirements.txt && \
    if [ ${DEV} = "true" ]; then \
        /env/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp/requirements.txt /tmp/requirements.dev.txt && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/env/bin:$PATH"

USER django-user

