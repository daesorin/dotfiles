#!/usr/bin/env bash
set -e

# VARIABLES
# define connection and path matrix
OCI_HOST="vault"
REMOTE_DIR="/opt/appdata/vaultwarden"
LOCAL_BACKUP_DIR="$HOME/backups/vaultwarden"
STAGING_DIR="/tmp/vaultwarden_staging"
FILEN_DIR="/Backup/vaultwarden"

# DATABASE SNAPSHOT
# execute a safe backup on the host to prevent sqlite corruption
echo "generating remote database snapshot..."
ssh "$OCI_HOST" "sudo sqlite3 $REMOTE_DIR/db.sqlite3 \".backup '$REMOTE_DIR/db_snapshot.sqlite3'\""
ssh "$OCI_HOST" "sudo chown 1000:1000 $REMOTE_DIR/db_snapshot.sqlite3"

# STAGING AND ISOLATION
# pull secure assets and ignore volatile memory mappings
echo "pulling secure assets to staging..."
mkdir -p "$STAGING_DIR"
rsync -avz --delete --rsync-path="sudo rsync" \
    --exclude='db.sqlite3' \
    --exclude='db.sqlite3-wal' \
    --exclude='db.sqlite3-shm' \
    --exclude='icon_cache/' \
    --exclude='tmp/' \
    "$OCI_HOST:$REMOTE_DIR/" "$STAGING_DIR/"

# PROMOTE SNAPSHOT
# replace the live database structure with the static snapshot
echo "promoting snapshot to primary database..."
mv "$STAGING_DIR/db_snapshot.sqlite3" "$STAGING_DIR/db.sqlite3"

# COMPRESSION AND ARCHIVING
# package the staging data into a timestamped tarball
echo "generating versioned archive..."
mkdir -p "$LOCAL_BACKUP_DIR"
TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
ARCHIVE_NAME="vaultwarden_backup_${TIMESTAMP}.tar.gz"
tar -czf "$LOCAL_BACKUP_DIR/$ARCHIVE_NAME" -C "$STAGING_DIR" .

# CLOUD UPLOAD
# push the compressed replica to the encrypted filen cloud
echo "pushing archive to filen..."
filen-cli upload "$LOCAL_BACKUP_DIR/$ARCHIVE_NAME" "$FILEN_DIR/"

# CLEANUP
# destroy ephemeral state on both machines
echo "cleaning state..."
ssh "$OCI_HOST" "sudo rm $REMOTE_DIR/db_snapshot.sqlite3"
rm -rf "$STAGING_DIR"

# RETENTION POLICY
# keep only the 7 most recent backups locally to preserve disk space
echo "enforcing local retention policy..."
ls -tp "$LOCAL_BACKUP_DIR"/vaultwarden_backup_*.tar.gz | grep -v '/$' | tail -n +8 | xargs -I {} rm -- {} 2>/dev/null || true

echo "backup sequence complete."
