# Use a stable Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /data

# Install system dependencies required for Django and Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-distutils \
        gcc \
        libpq-dev \
        curl \
        && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN python -m ensurepip && pip install --no-cache-dir --upgrade pip

# Install Django 3.2
RUN pip install --no-cache-dir django==3.2

# Copy project files
COPY . .

# Run Django migrations
RUN python manage.py migrate

# Expose port 8000
EXPOSE 8000

# Start Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]





