# ╔═════════════════════════════════╗
# ║          Android builder        ║
# ╚═════════════════════════════════╝
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

ENV ANDROID_SDK_ROOT="/usr/local/android-sdk" \
    ANDROID_VERSION=30 \
    ANDROID_BUILD_TOOLS_VERSION=30.0.3 \
    ANDROID_SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip" \
    GRADLE_VERSION=7.0.0 \
    TZ=Europe/Moscow \
    PATH=${ANDROID_SDK_ROOT}/tools:$ANDROID_HOME/platform-tools:$PATH

RUN apt-get update \
    && apt-get install --no-install-recommends -yy \
        git \
        curl \
        tzdata \
        unzip \
        openjdk-11-jre \
    && apt-get clean \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

# Развертывание SDK
RUN mkdir "$ANDROID_SDK_ROOT" \
    && cd "$ANDROID_SDK_ROOT" \
    && curl -o /tmp/sdk.zip $ANDROID_SDK_URL \
    && unzip /tmp/sdk.zip \
    && rm /tmp/sdk.zip

# Запускаем обновление SDK и установку build-tools, platform-tools
RUN cd ${ANDROID_SDK_ROOT}/cmdline-tools/bin/ \
    && ./sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --update \
    && yes Y | ./sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install \
        "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
        "platforms;android-${ANDROID_VERSION}" \
        "platform-tools" \
    && yes Y | ./sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses
