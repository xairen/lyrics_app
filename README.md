# Lyrics Web App

## Project Description

The Lyrics Web App is a Flutter-based web application designed to allow users to manage their song collection, including lyrics and associated MP3 files. It utilizes Firebase Firestore for storing song metadata and lyrics, and Firebase Storage for MP3 file uploads.

## Features

- **Song Management**: Users can add new songs, including title and lyrics.
- **Lyrics Editing**: Provides an interface for editing and saving song lyrics.
- **MP3 Upload**: Users can upload MP3 files for each song, storing them in Firebase Storage.

## Getting Started

### Prerequisites

- Flutter installed on your machine (See [Flutter installation guide](https://flutter.dev/docs/get-started/install))
- A Firebase project (See [Firebase Console](https://console.firebase.google.com/))

### Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/xairen/lyrics-app.git
   cd lyrics-app

2. **Check Firebase Configurations**

 - Navigate to the Firebase Console, select your project, and find your web app's Firebase configuration.
 - Create config/dev.json and config/prod.json in your project's assets folder with your Firebase project configuration.

3. **Flutter Config Files**

 - Update your 'pubspec.yaml' to include your Firebase configurations under assests folder

    ```yaml
    flutter:
        assets:
            - assets/config/dev.json
            - assets/config/prod.json
    
4. **Main functionality**

 - Adding a song
 - Editing Lyrics
 - Uploading MP3
