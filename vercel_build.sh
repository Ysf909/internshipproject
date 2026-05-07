#!/bin/bash
set -e

echo "→ Installing Flutter stable..."
git clone https://github.com/flutter/flutter.git \
  --depth 1 -b stable "$HOME/flutter" --quiet

export PATH="$PATH:$HOME/flutter/bin"

echo "→ Enabling Flutter web..."
flutter config --enable-web --no-analytics

echo "→ Getting dependencies..."
flutter pub get

echo "→ Building Flutter web (release)..."
flutter build web --release --web-renderer canvaskit

echo "✓ Build complete → build/web"
