# SPDX-FileCopyrightText: 2023 KOINSLOT, Inc.
#
# SPDX-License-Identifier: GPL-3.0-or-later

FROM espressif/idf:release-v5.1
MAINTAINER "KOINSLOT, Inc."

WORKDIR /build

COPY Pipfile* ./

RUN . /opt/esp/entrypoint.sh \
	&& pip install pytest pytest_embedded pytest_embedded_serial_esp pytest_embedded_idf reuse compdb pyyaml \
	&& curl -sSLfo /tmp/esp-clang https://github.com/espressif/llvm-project/releases/download/esp-16.0.0-20230516/llvm-esp-16.0.0-20230516-linux-amd64.tar.xz \
	&& tar -xf /tmp/esp-clang -C / \
	&& apt-get update \
	&& apt-get install -y \
		jq \
		otf2bdf \
	&& curl -sSLfo /usr/bin/yq https://github.com/mikefarah/yq/releases/download/v4.34.1/yq_linux_amd64 \
	&& chmod +x /usr/bin/yq \
	&& apt update \
	&& apt install -y imagemagick

ENV PATH="/esp-clang/bin:${PATH}"
