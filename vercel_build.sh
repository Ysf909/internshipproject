#!/bin/bash
set -e

FLUTTER_HOME="$HOME/flutter"

echo "→ Cloning Flutter stable..."
git clone https://github.com/flutter/flutter.git \
  --depth 1 -b stable "$FLUTTER_HOME" --quiet

export PATH="$PATH:$FLUTTER_HOME/bin"

# Silence analytics
export FLUTTER_SUPPRESS_ANALYTICS=true
export PUB_ENVIRONMENT=bot.github

echo "→ Flutter version:"
flutter --version --suppress-analytics

echo "→ Enabling web support..."
flutter config --enable-web

echo "→ Fetching packages..."
flutter pub get

echo "→ Building for web (release)..."
flutter build web --release

echo "✓ Done — output is in build/web"
