FROM alpine:latest

ARG PB_VERSION=0.21.3

RUN apk add --no-cache \
    unzip \
    su-exec \
    libuv-dev \
    hwloc-dev

# download and unzip PocketBase
ADD https://s3.tebi.io/r6w2bdxnvn/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/
RUN chmod +x /pb/pocketbase

# uncomment to copy the local pb_migrations dir into the container
# COPY ./pb_migrations /pb/pb_migrations

# uncomment to copy the local pb_hooks dir into the container
# COPY ./pb_hooks /pb/pb_hooks

EXPOSE 8080

# start PocketBase
CMD ["sh", "-c", "su-exec root /pb/pocketbase serve --http=0.0.0.0:8080 > /dev/null 2>&1"]

# Cluster No 1-0.1
