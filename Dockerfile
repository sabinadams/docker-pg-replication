FROM postgres
ENV POSTGRES_PASSWORD=postgres
COPY ./scripts/ /docker-entrypoint-initdb.d/
COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY pg_hba.conf /etc/postgresql/pg_hba.conf

EXPOSE 5432