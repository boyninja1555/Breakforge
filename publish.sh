#!/bin/bash
set -e

VERSION=$(grep -m 1 "<version>" pom.xml | sed -E "s/.*<version>(.+)<\/version>.*/\1/")
TAG="v$VERSION"

if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo "❌ Tag $TAG already exists. Bump the version in pom.xml first."
    exit 1
fi

git tag "$TAG"
git push origin "$TAG"

echo "✅ Tagged and pushed FloorIDE version $VERSION"
echo "🚀 GitHub Actions will now build and release the app"
