FROM python

WORKDIR ~/nightout/

COPY build/web .

EXPOSE 8080

CMD ["python", "-m", "http.server", "8080"]