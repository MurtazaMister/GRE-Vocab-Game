# GRE Vocab Game

## Motivation for this project
The aim of this project is to improve the vocabulary of a student in interactive manner. The project has dictionary of words which is maintain by the users. User can create and update the vocab of the dictionary. One hangman game is implemented using that dictionary.

## What problem does this project solve?
Many students preparing for the **Graduate Records Examination** need to have a strong set of vocabulary on their tips. Our application tries to make this learning process more interactive by providing a convenient platform for students around the globe to get together and evolve a database of GRE words, every student can add their words for themselves and the community and in return they will be able to view the words added by the community. A cherry at the top is after practicing words, they can play an interactive **Hangman** game to test their vocabulary with words from the database.

## Features
- A database curated by the students themselves.
- A *Hangman* game to test their vocabularies' skill set.

## Dependencies
> cupertino_icons: ^1.0.2  
> firebase_core: ^1.24.0  
> firebase_messaging: ^13.0.4  
> cloud_firestore: ^3.5.1  
> flutter_session_manager: ^1.0.3

## Setting up the project

- Install the dependencies of this project by running the following command in the terminal
```sh
flutter pub get
```

- Replace the ```google-services.json``` file in ```/android/app/``` with your firebase credentials

- Make sure a ```Java``` version greater than 11 is installed in your system, if more than one versions exist, add the following line in ```/android/gradle.properties```

```sh
org.gradle.java.home = C:\\Program Files\\Java\\jdk-17.0.1 # Path of your jdk
```

- Set your ```local.properties``` file in ```/android``` as per your System configurations
```sh
sdk.dir = C:\\Users\\Admin\\AppData\\Local\\Android\\sdk # Path to sdk directory
flutter.sdk = F:\\Flutter\\flutter # Path to flutter sdk
flutter.buildMode = debug # As it is
flutter.versionName = 1.0.0 # As it is
flutter.versionCode = 1 # As it is
```

# Thank You
