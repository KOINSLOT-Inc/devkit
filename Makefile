# SPDX-FileCopyrightText: 2023 KOINSLOT, Inc.
#
# SPDX-License-Identifier: GPL-3.0-or-later

.PHONY: build
build:
	docker build . -t kywy/devkit:latest
