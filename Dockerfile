FROM python:3.11.2-slim-bullseye

WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y imagemagick && \
        rm -rf /var/lib/apt/lists/*

RUN groupadd -r user && useradd -r -g user user

ARG SSAID
ARG UUID
ARG SEED

ENV OFTM_SSAID=$SSAID
ENV OFTM_UUID=$UUID
ENV OFTM_SEED=$SEED

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY src/requirements.txt requirements.txt
RUN pip install -U pip && pip --disable-pip-version-check install -r requirements.txt

COPY src/main.py main.py

USER user
CMD ["python3", "main.py"]