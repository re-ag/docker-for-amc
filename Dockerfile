ARG BASE
FROM ${BASE}
 
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
    gconf2 \
    gnome-terminal \
    language-pack-en \
    locales \
    sudo \
    vim \
    wget

RUN pip install tensorboardX 
RUN pip install scikit-learn

RUN update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX

#Add user
ENV USERNAME misys
ARG USER_ID=1000
ARG GROUP_ID=15214

RUN groupadd --gid $GROUP_ID $USERNAME && \
       useradd --gid $GROUP_ID -m $USERNAME && \
       echo "$USERNAME:$USERNAME" | chpasswd && \
       usermod --shell /bin/bash $USERNAME && \
       usermod -aG sudo $USERNAME && \
       usermod  --uid $USER_ID $USERNAME && \
       echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
       chmod 0440 /etc/sudoers.d/$USERNAME

# Startup scripts
ENV LANG="en_US.UTF-8"
RUN echo "export QT_X11_NO_MITSHM=1" >> /etc/profile.d/misys.sh && \
    echo "export LANG=\"en_US.UTF-8\"" >> /etc/profile.d/misys.sh

USER misys

# Configure terminal colors
RUN gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false && \
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false && \
    gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#000000"

RUN cd /home/misys && \
    git clone https://github.com/mit-han-lab/amc.git

COPY ./entrypoint.sh /tmp
# hadolint ignore=DL3002
USER root
ENTRYPOINT ["/tmp/entrypoint.sh"]