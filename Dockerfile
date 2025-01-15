# Базовый образ
FROM mcr.microsoft.com/playwright:v1.39.0-focal

# Убедись, что обновлены пакеты
RUN apt-get update && apt-get install -y \
    curl \
    && apt-get clean

# Установка Jenkins агента (если требуется)
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null && \
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list && apt-get update && apt-get install -y openjdk-11-jre-headless

# Установка зависимостей проекта
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# Установка браузеров Playwright
RUN npx playwright install

# Рабочий каталог
COPY . /app
