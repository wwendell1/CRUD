FROM python AS builder


RUN mkdir -p /code

WORKDIR /mysite

COPY requirements.txt /mysite

RUN pip install --upgrade pip
RUN set -ex && \
    pip install --upgrade pip setuptools wheel
    pip install -r requirements.txt
    rm -rf /root/.cache/    
COPY . /mysite

ENV SECRET_KEY "django-insecure-_jp+i(q1%hu^84h%ft$(27t*2%m+)@w+b_q0wan69kb3m!=+y0"
RUN python manage.py collectstatic --noinput

EXPOSE 8000

ENTRYPOINT ["python"]
CMD ["manage.py", "--bind", ":8000", "workers", "2", "type_event.wsgi]
