# FROM python:buster

# RUN mkdir -p /app/src

# WORKDIR /app/src

# # COPY Pipfile.lock .
# RUN set -xe \
#     && apt-get update \
#     && apt-get install python-pip


# COPY . .

FROM python:buster

WORKDIR /usr/src/app

# COPY requirements.txt ./
RUN pipenv install
# RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# CMD [ "python", "./your-daemon-or-script.py" ]

CMD ["pipenv","shell","&&","python","make.py"]
