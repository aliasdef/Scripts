#!/bin/bash
# Настройка путей
DIR="/home/hateme/Learning"
BACKUP_DIR="/home/hateme/bk"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="learning_backup_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

#Проверка на существование папки:
if [ -d "$DIR" ]; then
   # Закатываем в архив
   tar -czf "$BACKUP_DIR"/"$ARCHIVE_NAME" -C "$DIR" . 2>/dev/null
   echo "[$(date)] Бэкапы успешно созданы: $BACKUP_DIR"
else 
   echo "[$(date)] Ошибка: Директория $DIR не найдена!"
   exit 1
fi


find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +14 -delete
