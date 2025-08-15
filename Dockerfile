FROM python:3.11-slim

WORKDIR /data

# Install system dependencies for Django and Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        curl \
        wget \
        unzip \
        && rm -rf /var/lib/apt/lists/*

# Install distutils via ensurepip (works in Python >=3.10)
RUN python -m ensurepip && \
    python -m pip install --upgrade pip setuptools wheel

# Install Django 3.2
RUN pip install django==3.2

# Copy project files
COPY . .

# Run Django migrations
RUN python manage.py migrate

# Expose port 8000
EXPOSE 8000

# Start Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
