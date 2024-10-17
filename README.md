# the_cultural_ninja

A new Flutter project.

## Getting Started

# here is the jks file command ::::::
##  keytool -genkey -v -keystore D:\the_cultural_ninja\android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias uploadkeystore

# here is the sha command ::::::::
## keytool -keystore D:\the_cultural_ninja\android\app\upload-keystore.jks -list -v


# google console
# new project
# Project name
# create
# select project
# search
# oauth consent screen 
#  external
# create
# App Name
# save and continue  3 
# back to dashboard
# credentials
# create credentials
# oauth client id
# application type
# package name
# ShA_1
# jks file create
# create

# client id: 267183048621-a1db7e6v2vliil4b4ssqcve1b5bcenc0.apps.googleusercontent.com


# enabled apis and service
# search  === Google calendar api
# Enable


//////////////////////////////////////////////////////////////////////////////////////
 # add pubspec.yaml
googleapis: ^9.1.0
googleapis_auth: ^1.0.3
http: ^0.13.4
flutter_web_auth: ^0.5.0 # You may downgrade if you're on an older Dart version.
intl: ^0.17.0