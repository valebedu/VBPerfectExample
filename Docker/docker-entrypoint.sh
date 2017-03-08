#!/bin/bash

# Clean useless dependencies in RELEASE environment
if [[ $DB_ENVIRONMENT == "RELEASE" ]]; then
    apt-get purge \
        libmysqlclient-dev \
        clang pkg-config libmariadb2 libmariadb-client-lgpl-dev libcurl4-openssl-dev \
        libpq-dev \
        libmongoc-dev
fi

# Select right dependencies for choosen database
case $DB_TYPE in
    "MYSQL" ) DB_DEPENDENCIES="libmysqlclient-dev"
        ;;
    "MARIA" ) DB_DEPENDENCIES="clang pkg-config libmariadb2 libmariadb-client-lgpl-dev  libcurl4-openssl-dev"
        ;;
    "POSTGRE" ) DB_DEPENDENCIES="libpq-dev"
        ;;
    "MONGO" ) DB_DEPENDENCIES="libmongoc-dev"
        ;;
    * ) DB_DEPENDENCIES=""
        ;;
esac

# Install dependencies
if [[ DB_DEPENDENCIES != "" ]]; then
    apt-get update && \
        apt-get install -y \
        $DB_DEPENDENCIES
fi

# Go into repository
cd $PERFECT_TARGET_PATH/$PERFECT_TARGET_REPOSITORY

# Clean build
if [[ $PERFECT_ENVIRONMENT == "DEBUG" ]]; then
    swift build --clean build
    PERFECT_BUILD="debug"
else
    swift build --clean dist
    PERFECT_BUILD="release"
fi

# Build
swift build --configuration $PERFECT_BUILD

# Run
.build/$PERFECT_BUILD/$PERFECT_TARGET_REPOSITORY
