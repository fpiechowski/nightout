FROM ubuntu

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

RUN mkdir /nightout/
COPY . /nightout/
WORKDIR /nightout

EXPOSE 8080

RUN flutter build web --web-renderer=canvaskit --web-port=8080

RUN dart pub global activate dhttpd

CMD dhttpd --path build/web