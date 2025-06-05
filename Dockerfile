FROM python:3.11-slim

# Устанавливаем необходимые системные зависимости
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    mc \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install curl -y && rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файл requirements.txt в контейнер
COPY requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь проект в контейнер, включая подкаталоги

COPY ./app/app.py ./app.py
COPY ./app/templates/index.html ./templates/index.html
COPY ./app/static/style.css ./static/style.css
COPY ./app/static/fon/sta.gif ./static/fon/sta.gif

# Открываем порт 5000 для Flask
EXPOSE 5000

# Запускаем приложение
CMD ["python3", "app.py"]