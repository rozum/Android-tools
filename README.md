# Android tools
Shell scripts to facilitate routine actions when developing an Android application

- __app-tester-deploy.sh__
  Shell script for deploy Android application with Firebase AppTester. You must run from the project folder to use.
  
- __xml2svg__
  Converter vector drawable to Svg. Source page: https://gitlab.com/AlessandroLucchet/VectorDrawable2Svg

- __Dockerfile__
  Description of the container for build an application
  ```
  docker build -t android-builder .
  docker run --rm -v "$PWD":/home/gradle/ -w /home/gradle android-builder ./gradlew assembleDebug
  ```

