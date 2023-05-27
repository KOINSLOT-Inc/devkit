# SPDX-FileCopyrightText: 2023 KOINSLOT, Inc.
#
# SPDX-License-Identifier: GPL-3.0-or-later

.PHONY: lint
lint:
	docker run --rm -v $$PWD:/data -w /data kywy/devkit:latest reuse lint

.PHONY: build
build:
	docker build . -t kywy/devkit:latest
