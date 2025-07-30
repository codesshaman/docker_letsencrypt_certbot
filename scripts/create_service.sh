#!/bin/bash

# Сохраняем текущую директорию в переменную
CURRENT_DIR=$(pwd)

# Сохраняем текущего пользователя в переменную
CURRENT_USER=$(whoami)

# Путь к файлу
SERVICE_PATH="/etc/systemd/system/certbot.service"

# Проверяем, существует ли файл
if [ -f "$SERVICE_PATH" ]; then
    echo "Файл $SERVICE_PATH уже существует."
else
    echo "Файл $SERVICE_PATH отсутствует. Создаём файл..."

    # Содержимое для файла
    SERVICE_CONTENT="[Unit]

Description=Renew Let's Encrypt certificates using Certbot in Docker
After=docker.service
Requires=docker.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/certbot-docker-renew.sh"

    # Создаём файл под sudo и записываем содержимое
    echo "$SERVICE_CONTENT" | sudo tee "$SERVICE_PATH" > /dev/null
    
    # Устанавливаем корректные права доступа
    sudo chmod 644 "$SERVICE_PATH"
    echo "Файл $SERVICE_PATH успешно создан."

    # Перезапускаем systemd для применения изменений
    sudo systemctl daemon-reload
    echo "Systemd перезагружен."
fi
