NAME := kube-commands
REGISTRY := codejamninja
VERSION := 0.0.2
IMAGE := $(REGISTRY)/$(NAME)

include docker.mk

%:
	@
