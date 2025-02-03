FROM python:3.13

WORKDIR /app

COPY requirements.txt /app/

RUN pip install -r requirements.txt --no-cache-dir

COPY . /app/

CMD python3 main.py