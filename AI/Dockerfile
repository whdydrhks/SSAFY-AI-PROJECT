# # Use the official Python image as the base image
# FROM python:3.9.2

# WORKDIR /app

# # Copy the requirements.txt file into the container
# COPY requirements.txt .

# # Install the dependencies
# RUN pip install --trusted-host pypi.python.org --index-url https://pypi.org/simple --no-cache-dir -r requirements.txt
# RUN pip install --no-cache-dir 'git+https://github.com/SKTBrain/KoBERT.git#egg=kobert_tokenizer&subdirectory=kobert_hf'
# RUN pip install --no-cache-dir kobert-transformers==0.4.1

# # Copy the rest of the application code into the container
# COPY . .

# # Expose the port the app will run on
# EXPOSE 8000

# # Start the application using Gunicorn
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

FROM python:3.9.2


COPY . .
COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN pip install --trusted-host pypi.python.org --index-url https://pypi.org/simple --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir 'git+https://github.com/SKTBrain/KoBERT.git#egg=kobert_tokenizer&subdirectory=kobert_hf'
RUN pip install --no-cache-dir kobert-transformers==0.4.1

EXPOSE 5000

CMD ["python", "run", "server"]