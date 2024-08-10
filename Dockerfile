# base image
FROM debian:testing

# install extra software
RUN apt-get update && apt-get -y install neovim zsh zsh-syntax-highlighting zsh-autosuggestions git sudo nodejs npm stow tmux make gcc g++ libc-dev htop util-linux curl wget tree-sitter-cli zoxide ripgrep fzf fd-find

# fix locale
RUN apt-get install -y locales && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# add non-root user
RUN adduser --disabled-password --shell /bin/zsh zig && \
    echo 'zig ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers.d/99_zig

# make directory for mount
RUN mkdir -p /workspace && chown zig:zig /workspace

# default user
USER zig

# better use of image cache for neovim plugins and treesitter parsers
RUN mkdir -p ~/.config/nvim/lua/cfg
COPY --chown=zig:zig ./nvim/.config/nvim/init.lua \
                     /home/zig/.config/nvim
COPY --chown=zig:zig ./nvim/.config/nvim/lua/cfg/plugins.lua \
                     ./nvim/.config/nvim/lua/cfg/nvim-treesitter.lua \
                     /home/zig/.config/nvim/lua/cfg
# init neovim
# HACK: there isn't a way to detect if TSInstall finished, so we sleep and hope it is enough...
# We could do a sync install, but that takes forever (> 7m instead of just 1m30s)
RUN nvim -c "sleep 120" -c "quit"
# Remove config files to avoid conflicts with stow
RUN rm -r ~/.config/nvim

# Configure python installation
RUN sudo apt-get -y install python3-full python-is-python3 black
RUN sh -c 'cd && python3 -m venv env && . env/bin/activate && \
           pip install requests ipython ipywidgets jupyterlab jupyterlab-vim pandas scikit-learn scipy matplotlib gradio streamlit django'

# Extra packages
RUN sudo apt-get update && sudo apt-get -y install golang hugo

# install dotfiles
# git clone
# RUN cd && \
#     git clone https://github.com/kakig/dotfiles .dotfiles && \
#     cd .dotfiles && \
#     git submodule update --init zsh/.config/zsh/powerlevel10k
# copy repo
COPY --chown=zig:zig . /home/zig/.dotfiles
RUN rm ~/.bashrc ~/.profile && \
    cd ~/.dotfiles && \
    ls -la && \
    stow -v bash bin gdb nvim gitconfig profile readline tmux zsh && \
    sh -c 'echo ". ~/env/bin/activate" >> ~/.zshrc'

# init zsh
RUN echo exit | script -qec zsh /dev/null >/dev/null

WORKDIR /workspace

# Extra extra packages
RUN sudo apt-get update && sudo apt-get -y install ranger

# ENTRYPOINT tmux
CMD tmux
