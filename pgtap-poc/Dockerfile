FROM postgres:16

# Install pgTAP + pg_prove
RUN apt-get update \
  && apt-get install -y postgresql-16-pgtap libtap-parser-sourcehandler-pgtap-perl \
  && rm -rf /var/lib/apt/lists/*
