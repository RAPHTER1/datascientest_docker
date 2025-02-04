FROM python:3.13 as build

WORKDIR /app

COPY requirements.txt /app/

RUN pip install -r requirements.txt --no-cache-dir -t /app/dependencies

COPY . /app/

FROM python:3.13-alpine

WORKDIR /app

COPY --from=build /app /app

ENV PYTHONPATH=/app/dependencies

CMD python3 main.py