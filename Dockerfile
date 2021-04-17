FROM python:3

WORKDIR /usr/local/js_example

COPY * /usr/local/js_example/

ENV FLASK_APP js_example

EXPOSE 5000

RUN pip install -e .

CMD flask run --host=0.0.0.0
