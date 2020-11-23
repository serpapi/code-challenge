FROM python:3.7-alpine
ADD . /src
WORKDIR /src
RUN pip install -r requirement.txt
CMD python -m scraper