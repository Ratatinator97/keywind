FROM quay.io/keycloak/keycloak:26.5.0 as builder

# Add custom provider JARs before the build
ADD --chown=keycloak:keycloak --chmod=644 ./plugins/ /opt/keycloak/providers/

# Run the build command
RUN /opt/keycloak/bin/kc.sh build

# Final stage
FROM quay.io/keycloak/keycloak:26.5.0

# Copy built artifacts from builder
COPY --from=builder /opt/keycloak/lib /opt/keycloak/lib
COPY --from=builder /opt/keycloak/providers /opt/keycloak/providers

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
