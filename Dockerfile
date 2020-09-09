FROM python:3.8-alpine as base

# Install dependencies
FROM base as dependencies
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Run tests
FROM dependencies as test
COPY ./ /
RUN /testing/test.sh && touch /test-success

# Copy assets
FROM dependencies as production
COPY --from=test /test-success /
COPY ./assets/ /opt/resource/
