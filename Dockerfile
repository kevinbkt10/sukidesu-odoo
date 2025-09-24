# Imagem oficial do Odoo (multi-arch). Ajuste a major via ARG.
ARG ODOO_VERSION=19.0
FROM odoo:${ODOO_VERSION}

USER root
# Config do Odoo
COPY ./odoo.conf /etc/odoo/odoo.conf

# Clona os módulos Enterprise (repo privado) durante o build
ARG GH_USER
ARG GH_TOKEN
RUN set -eux; \
    apt-get update && apt-get install -y --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/*; \
    mkdir -p /mnt/enterprise; \
    git clone --depth=1 -b ${ODOO_VERSION} https://${GH_USER}:${GH_TOKEN}@github.com/odoo/enterprise.git /mnt/enterprise; \
    chown -R odoo:odoo /mnt/enterprise

USER odoo
