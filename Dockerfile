FROM cirrusci/flutter

COPY . /nightout

WORKDIR /nightout

RUN flutter build web --web-renderer=canvaskit

RUN dart pub global activate dhttpd

CMD dhttpd --path build/web