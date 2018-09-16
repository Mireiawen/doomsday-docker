FROM "bitnami/minideb:stretch"

MAINTAINER "Mira Liikanen <mir@mireiawen.net>"

# Doomsday version
ARG Doomsday="2.0.3"
ARG DOOM_WAD="http://distro.ibiblio.org/slitaz/sources/packages/d/doom1.wad"

# Do the installation
RUN \
	install_packages "curl" \
		"libncurses5" \
		"libminizip1" \
		"libqt5gui5" \
		"libqt5x11extras5" \
		"libsdl2-mixer-2.0-0" \
		"libxrandr2" \
		"libxxf86vm1" \
		"libfluidsynth1" \
		"libqt5opengl5" && \
	mkdir "/app" && \
	cd "/app" && \
	curl \
		"http://files.dengine.net/archive/doomsday_${Doomsday}_amd64.deb" \
		--output "doomsday_${Doomsday}_amd64.deb" && \
	dpkg --install "doomsday_${Doomsday}_amd64.deb" && \
	rm "doomsday_${Doomsday}_amd64.deb"

# Add WAD
RUN \
	mkdir --parents "/app/wads" && \
	curl \
		"${DOOM_WAD}" \
		--output "/app/wads/doom1.wad"

# Add Config
COPY "autoexec.cfg" "/app/config/autoexec.cfg"

# Define mountable volumes
VOLUME [ "/app/wads", "/app/config" ]

# Doomsday port
EXPOSE 13209

# Server setup
ENTRYPOINT [ "doomsday-server" ]
CMD [ "--version" ]
