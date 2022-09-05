FROM python

WORKDIR ~/nightout/

COPY build/web .

CMD python -m http.server 8080