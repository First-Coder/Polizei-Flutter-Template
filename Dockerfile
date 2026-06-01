# ---------- Build Stage ----------
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

COPY . .

RUN flutter pub get
RUN flutter build web --release

# ---------- Runtime Stage ----------
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]