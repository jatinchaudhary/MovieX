# MovieX

A Flutter Movie Catalog App 🎬

## Overview
I have created a **Movie catalog app** where you can:
- See **trending movies** and **now playing movies**
- **Bookmark** your favorite movies for later
- **Search** different movies quickly with a smooth user experience
- Use the **deep link feature** to share movies with friends

## Features
- Trending movies list
- Now playing movies list
- Bookmark & Saved movies section
- Search with debounce (instant results as you type)
- Deep linking to share and open movie details
- Offline caching with local database support

## Setup & Run
To run this project locally:

1. Clone the repo:
   ```bash
   git clone https://github.com/jatinchaudhary/MovieX.git
   cd MovieX

2. Install dependencies:
   ```bash
   flutter pub get

3. Run build runner (for generated code):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs

4. Add your TMDB API key in:
   ```bash
   lib/constants/api_constants.dart

5. Run the app:
   ```bash
   flutter run

