TAG := zdvickery

.PHONY: build

all: build

build:
	docker build -t ${TAG}/dns-proxy .

push:
	docker push ${TAG}/dns-proxy
