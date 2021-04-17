FROM python:3

COPY student-exam2 student-exam2

WORKDIR student-exam2

ENV FLASK_APP js_example

EXPOSE 5000

RUN pip install -e .

CMD flask run --host=0.0.0.0
