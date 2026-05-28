# Automated Linux Backup & Rotation Script

A production-ready Bash script designed to automate directory backups into compressed archives with built-in retention policies (rotation) and timestamp logging.

## Features

*   **On-the-Fly Compression**: Packs the target directory into `tar.gz` format while maintaining file permissions.
*   **Dynamic Timestamps**: Automatically generates unique archive names using the `YYYY-MM-DD_HH-MM-SS` mask.
*   **Intelligent Retention (Rotation)**: Scans the backup storage and automatically wipes archives older than 14 days to prevent disk space exhaustion.
*   **Data Validation**: Built-in sanity check to ensure the target directory exists before starting the compression block.


##  Deployment Guide

### 1. Permissions Setup
Clone the script and grand execution privileges:
```bash
chmod +x backup.sh
```

### 2. Manual Execution
To force an instant backup run:
```bash
./sctipt.sh
```

### 3. Automation via Cron Scheduler
To set up a regular background backup task, open the `crontab` editor:
```bash
crontab -e
```
Append the following line to the end of the file to execute the script **every Monday at 18:00 (6:00 PM)**:
```text
0 18 * * 1 /path_to_script/backup.sh
```

## Configuration Variables

Customize the behavior by editing the paths inside the script [🎯]:
*   `DIR` — Absolute path to the source directory you want to back up.
*   `BACKUP_DIR` — Destination path where compressed archives will be stored.

## Security & Compliance Note

This tool is designed with infrastructure security in mind. The rotation mechanism utilizing `find -mtime +14 -delete` runs locally and deterministically, preventing command injection vectors from low-privileged users.
