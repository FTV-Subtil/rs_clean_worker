FROM rust:1.31-stretch as builder

ADD . ./

RUN apt update && \
    cargo build --verbose --release && \
    cargo install

FROM debian:stretch
COPY --from=builder /usr/local/cargo/bin/file_system_worker /usr/bin

ENV AMQP_QUEUE=job_file_system
CMD file_system_worker
