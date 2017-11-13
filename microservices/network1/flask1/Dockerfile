FROM python:3.6.1

RUN pip install flask

COPY app.py hitchhikers_quotes.txt /home/
# copies two files in one layer 

WORKDIR /home/
