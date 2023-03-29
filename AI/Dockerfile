FROM python:3.9.0

ENV PYTHONUNBUFFERED = 1

RUN mkdir /app

WORKDIR /app

COPY requirements.txt /app/

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN pip install --trusted-host pypi.python.org --index-url https://pypi.org/simple --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir 'git+https://github.com/SKTBrain/KoBERT.git#egg=kobert_tokenizer&subdirectory=kobert_hf'
RUN pip install --no-cache-dir kobert-transformers==0.4.1

COPY . /app/

ENV DJANGO_SETTINGS_MODULE=aipjt.settings

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]