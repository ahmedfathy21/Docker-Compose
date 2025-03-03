# ---- Build Stage ----
    FROM python:3.9-slim AS build
    WORKDIR /app
    
    # Copy dependency files
    COPY requirements.txt ./
    RUN pip install --no-cache-dir -r requirements.txt
    
    # Copy the rest of the application code
    COPY . .
    
    # ---- Run Stage ----
    FROM python:3.9-slim
    WORKDIR /app
    
    # Copy the built application from the previous stage
    COPY --from=build /app ./
    
    # Expose the port Flask runs on
    EXPOSE 5000
    
    # Start the Flask application
    CMD ["python", "app.py"]
    