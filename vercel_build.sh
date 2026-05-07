#!/bin/bash
set -e

echo "→ Installing Flutter stable..."
git clone https://github.com/flutter/flutter.git \
  --depth 1 -b stable "$HOME/flutter" --quiet

export PATH="$PATH:$HOME/flutter/bin"
export FLUTTER_SUPPRESS_ANALYTICS=true

echo "→ Enabling Flutter web..."
flutter config --enable-web --no-analytics --suppress-analytics

echo "→ Getting dependencies..."
flutter pub get --suppress-analytics

echo "→ Building Flutter web (release)..."
flutter build web --release --suppress-analytics \
  --allow-root 2>/dev/null || \
flutter build web --release --suppress-analytics

echo "✓ Build complete → build/web"
