#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/.env" ]; then
  export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs)
fi

echo "さくらインターネットサーバーへアップロード中..."
curl --ssl-reqd --ftp-create-dirs -u "${DEPLOY_USER}:${DEPLOY_PASS}" \
  -T "$SCRIPT_DIR/index.html" \
  "ftp://${DEPLOY_HOST}${DEPLOY_PATH}index.html"

echo "デプロイ完了: https://www.lyt.jp/ws/ (https://${DEPLOY_HOST}/ws/)"
