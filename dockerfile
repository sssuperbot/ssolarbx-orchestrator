FROM python:3.9-slim

WORKDIR /ansible

RUN apt-get update && \
    apt-get install -y sshpass openssh-client && \
    pip install --no-cache-dir ansible && \
    apt-get clean

COPY . /ansible

CMD ["ansible-playbook", "--version"]