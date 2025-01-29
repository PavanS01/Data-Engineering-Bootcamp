FROM python:3.12.8

RUN apt-get install wget
RUN apt-get install gzip
RUN pip install pandas pyarrow psycopg2-binary sqlalchemy

WORKDIR /app
COPY ingest_data_1.py ingest_data_1.py
ENTRYPOINT ["python","ingest_data.py"]