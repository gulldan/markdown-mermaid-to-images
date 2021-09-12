FROM pandoc/core:2.14.1

COPY . .

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV CHROMIUM_PATH /usr/bin/chromium-browser

RUN apk update && \
    echo > /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
    chromium \
    nss \
    harfbuzz \
    nodejs \
    npm \
    yarn \
    python3 \
    py3-pip && \
    pip3 install --upgrade pip setuptools && \
    pip3 install -r requirements.txt && \
    pip3 install -e .

# RUN npm install @mermaid-js/mermaid-cli && \
RUN yarn add @mermaid-js/mermaid-cli && \
    mkdir input output && \
    ln -sf /data/node_modules/@mermaid-js/mermaid-cli/index.bundle.js /usr/local/bin/mmdc && \
# need to remove files
# rm -r dist/ && \
    rm -rf /tmp/* /var/cache/apk/

ENTRYPOINT /bin/ash

# CMD [ "markdown_mermaid_to_images", "-f", "/data/input", "-o", "/data/output"]
