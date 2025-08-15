FROM python:3

WORKDIR /data

# Install distutils (needed for Django 3.2)
RUN apt-get update && \
    apt-get install -y python3-distutils && \
    rm -rf /var/lib/apt/lists/*

# Install Django
RUN pip install --no-cache-dir django==3.2

# Copy project files
COPY . .

# Run migrations
RUN python manage.py migrate

# Expose port
EXPOSE 8000

# Start the server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]




