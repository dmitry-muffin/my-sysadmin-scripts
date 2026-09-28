#!/bin/bash

# Интервал опроса системы в секундах
INTERVAL=5

# Файл для записи логов
LOG_FILE="monitor.log"

# Проверка файла для записи логов
if ! touch "$LOG_FILE"; then
    echo "Ошибка: не удалось открыть '$LOG_FILE' для записи." >&2
    exit 1
fi

# Сообщение о запуске скрипта
echo "Мониторинг запущен. Результаты сохраняются в $LOG_FILE"

# Бесконечный цикл мониторинга
while true; do

    # Записываем разделитель с временной меткой
    echo "--- $(date "+%Y-%m-%d %H:%M:%S") ---" >> "$LOG_FILE"

    # Снимаем показатели и дописываем в файл
    echo "=== Uptime ===" >> "$LOG_FILE"
    uptime >> "$LOG_FILE"

    echo "=== Memory Usage ===" >> "$LOG_FILE"
    free -h >> "$LOG_FILE"

    echo "=== Disk Usage ===" >> "$LOG_FILE"
    df -h >> "$LOG_FILE"

    # Запись пустой строки (разделлитель)
    echo "" >> "$LOG_FILE"

    # Ждем N секунд перед следующим циклом
    sleep "$INTERVAL"
done
