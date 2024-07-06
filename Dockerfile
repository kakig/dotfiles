# base image
FROM alpine:3.20

# install extra software
RUN apk add neovim zsh zsh-syntax-highlighting zsh-autosuggestions git sudo nodejs stow tmux make gcc g++ musl-dev libc-dev util-linux htop

# add non-root user
RUN adduser -D -s /bin/zsh zig && \
    echo 'zig ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers.d/99_zig

# make directory for mount
RUN mkdir -p /workspace && chown zig:zig /workspace

# default user
USER zig

# install dotfiles
# git clone
# RUN cd && \
#     git clone https://github.com/kakig/dotfiles .dotfiles && \
#     cd .dotfiles && \
#     git submodule update --init zsh/.config/zsh/powerlevel10k
# copy repo
COPY --chown=zig:zig . /home/zig/.dotfiles
RUN cd ~/.dotfiles && ls -la && stow -v bash bin gdb nvim gitconfig profile readline tmux zsh 

# init neovim
# HACK: there isn't a way to detect if TSInstall finished, so we sleep and hope it is enough...
# We could do a sync install, but that takes forever (> 7m instead of just 1m30s)
RUN nvim -c "sleep 90" -c "quit"

# init zsh 
RUN echo exit | script -qec zsh /dev/null >/dev/null

WORKDIR /workspace

ENTRYPOINT tmux
