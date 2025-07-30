#!/bin/bash

# Сохраняем текущую директорию в переменную
CURRENT_DIR=$(pwd)

# Считываем путь к docker-compose
COMPOSE_ROOT="$(grep "COMPOSE_ROOT" .env | sed -r 's/.*=//')"

# Считываем имя контейнера
CONTAINER_NAME="$(grep "CERTBOT_NAME" .env | sed -r 's/.*=//')"

# Сохраняем текущего пользователя в переменную
CURRENT_USER=$(whoami)

# Путь к файлу
SERVICE_PATH="/usr/local/bin/certbot-docker-renew.sh"

# Проверяем, существует ли файл
if [ -f "$SERVICE_PATH" ]; then
    echo "Файл $SERVICE_PATH уже существует."
else
    echo "Файл $SERVICE_PATH отсутствует. Создаём файл..."

    # Содержимое для файла
    SERVICE_CONTENT="#!/bin/bash

cd ${CURRENT_DIR} || exit 1
${COMPOSE_ROOT} run --rm ${CONTAINER_NAME} renew --quiet
# ${COMPOSE_ROOT} exec nginx nginx -s reload 2>/dev/null || true"

    # Создаём файл под sudo и записываем содержимое
    echo "$SERVICE_CONTENT" | sudo tee "$SERVICE_PATH" > /dev/null
    
    # Устанавливаем корректные права доступа
    sudo chmod +x "$SERVICE_PATH"
    echo "Файл $SERVICE_PATH успешно создан."
fi
