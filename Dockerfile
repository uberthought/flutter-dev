FROM ubuntu:latest

RUN apt update && apt install -y curl git unzip xz-utils zip wget software-properties-common openjdk-11-jdk

RUN add-apt-repository -y ppa:maarten-fonville/android-studio
RUN apt update
RUN apt install android-studio -y

WORKDIR /root
   
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/root/flutter/bin"
RUN echo export PATH="$PATH:/root/flutter/bin" >> ~/.bashrc
   
RUN flutter doctor
RUN flutter precache
RUN flutter upgrade

WORKDIR /opt/android-sdk
# COPY ./commandlinetools-linux-9477386_latest.zip .
RUN curl https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip --output commandlinetools-linux-9477386_latest.zip 
RUN unzip commandlinetools-linux-9477386_latest.zip

ENV PATH "$PATH:/opt/android-sdk/cmdline-tools/bin:/opt/android-studio/bin:/opt/android-sdk/platform-tools/bin"
RUN echo export PATH="$PATH:/opt/android-sdk/cmdline-tools/bin:/opt/android-studio/bin:/opt/android-sdk/platform-tools/bin" >> ~/.bashrc

RUN yes | sdkmanager --sdk_root=/opt/android-sdk "cmake;3.10.2.4988404" "platforms;android-33" "cmdline-tools;latest" "platform-tools" "ndk;25.2.9519653" "build-tools;33.0.2"

RUN flutter config --android-sdk=/opt/android-sdk
RUN yes | flutter doctor --android-licenses

RUN apt install -y clang cmake pkg-config ninja-build libgtk-3-dev


# RUN echo export ANDROID_HOME=/opt/android-sdk >> ~/.bashrc
# flutter run -d web-server --debug
