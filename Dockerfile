FROM python:3.9.0-alpine
WORKDIR /app
ADD README.md /app/README.md
RUN pip install marko && \
    mkdir /app/build && \
    echo '<html lang="ru"><header><meta charset="UTF-8"></header><body>' > build/index.html && \
    cat README.md | marko >> build/index.html && \
    echo '</body></html>' >> build/index.html

FROM nginx:1.21.3-alpine
COPY --from=0 /app/build /usr/share/nginx/html
