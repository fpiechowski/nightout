FROM ubuntu

RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

RUN mkdir /nightout/
COPY . /nightout/
WORKDIR /nightout

EXPOSE 5000

RUN flutter build web --web-renderer=canvaskit

RUN dart pub global activate dhttpd

CMD dhttpd --path build/web