FROM node:7-alpine
# A few problems with compiling Java from source:
#  1. Oracle.  Licensing prevents us from redistributing the official JDK.
#  2. Compiling OpenJDK also requires the JDK to be installed, and it gets
#       really hairy.

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u121
ENV JAVA_ALPINE_VERSION 8.111.14-r0

RUN set -x \
	&& apk add --no-cache \
		openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

RUN npm install -g nightwatch
RUN mkdir -p /usr/opt
WORKDIR /usr/opt/
# 下载 Selenium
# http://selenium-release.storage.googleapis.com/index.html
ENV SELENIUM_VERSION 3.3.1
RUN apk add --no-cache curl \
    && curl -SLO "http://selenium-release.storage.googleapis.com/3.3/selenium-server-standalone-$SELENIUM_VERSION.jar" 

# 下载 GeckoDriver
# https://github.com/mozilla/geckodriver/releases
# ENV GECKO_DRIVER_VERSION 0.15.0
# RUN apk add --no-cache curl \
#     && curl -SLO "https://github.com/mozilla/geckodriver/releases/download/v$GECKO_DRIVER_VERSION/geckodriver-v$GECKO_DRIVER_VERSION-linux64.tar.gz" \
#     && tar -xf "geckodriver-v$GECKO_DRIVER_VERSION-linux64.tar.gz" 

# 下载 ChromeDriver
# https://sites.google.com/a/chromium.org/chromedriver/downloads
# ENV CHROME_DRIVER_VERSION 2.29
# RUN apk add --no-cache curl \
#     && curl -SLO "https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip" \
#     && unzip "chromedriver_linux64.zip" 
RUN apk add --no-cache  --update chromium chromium-chromedriver

# 下载 Microsoft WebDriver (only win)
# ENV WEB_DRIVER_VERSION 7u121
# RUN curl -SLO "https://download.microsoft.com/download/3/4/2/342316D7-EBE0-4F10-ABA2-AE8E0CDF36DD/MicrosoftWebDriver.exe" \
#     && tar -xf "MicrosoftWebDriver.exe" 

RUN mkdir -p /usr/tests 
WORKDIR /usr/tests
