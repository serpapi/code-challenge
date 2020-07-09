FROM joyzoursky/python-chromedriver:3.6-selenium
RUN pip install --upgrade pip
RUN pip install nose
RUN mkdir /app
COPY ./image_extractor /app/image_extractor
COPY ./test /app/test
COPY run.py /app
WORKDIR /app
CMD ["nosetests"]