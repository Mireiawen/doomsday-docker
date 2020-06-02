FROM "bitnami/minideb:buster"

# Doomsday version
ARG doomsday_version="2.2.2"

# Doom WAD URL
ARG doom_wad_url="http://distro.ibiblio.org/slitaz/sources/packages/d/doom1.wad"

# Install libraries
RUN install_packages \
	"curl" \
	"libncurses5" \
	"libminizip1" \
	"libqt5gui5" \
	"libqt5x11extras5" \
	"libsdl2-mixer-2.0-0" \
	"libxrandr2" \
	"libxxf86vm1" \
	"libfluidsynth1" \
	"libqt5opengl5"

# Add the shareware WAD
RUN mkdir --parents "/app/wads"
RUN curl --silent --show-error \
	"${doom_wad_url}" \
	--output "/app/wads/doom1.wad"

# Add the initial config
RUN mkdir --parents "/app/config"
COPY "autoexec.cfg" "/app/config/autoexec.cfg"

# Install Doomsday Engine
RUN cd "/tmp" && \
	curl --silent --show-error \
		"http://files.dengine.net/archive/doomsday_${doomsday_version}_amd64.deb" \
		--output "doomsday_${doomsday_version}_amd64.deb" && \
	dpkg --install "doomsday_${doomsday_version}_amd64.deb" && \
	rm "doomsday_${doomsday_version}_amd64.deb"


# Define mountable volumes
VOLUME [ "/app/wads", "/app/config" ]

# Doomsday port
EXPOSE "13209"

# Server setup
ENTRYPOINT [ "doomsday-server" ]
CMD [ "--version" ]
