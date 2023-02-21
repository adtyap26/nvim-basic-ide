FROM alpine:latest

LABEL maintainer="adtyap26"
LABEL description="Use Docker to contain my NVIM configs"
LABEL version="1.0"

# user related args
ARG NEOVIM_LSP="lua_ls \
  cssls \
  emmet_ls \
  tsserver \
  pyright \
  bashls \
  jsonls \
  sqlls \
  yamlls \
  dockerls \
  gopls \
  marksman"
# alpine sdk and neovim come with LuaJIT no need to add it ourselves
# setup the basic system
RUN apk update && apk upgrade
RUN apk add git \
  nodejs \
  neovim \
  ripgrep \
  alpine-sdk \
  xclip \
  neovim-doc \
  shadow \
  bash \
  curl \
  go \
  rust \
  cargo \
  npm

# RUN npm install -g dockerfile-language-server-nodejs \
#   @kozer/emmet-language-server \
#   pyright \
#   bash-language-server \
#   vscode-json-languageserver \
#   yaml-language-server \
#   marksman \
#   prettier

RUN go install golang.org/x/tools/gopls@latest


# set up working directory and entrypoint
WORKDIR /root

# # set cargo path into users bashrc
# RUN echo "export PATH=${HOME}/.cargo/bin" >> ${HOME}/.bashrc
#
# Copy ENV for golang and rust
COPY .bashrc .bashrc

# use ours or direct nvchad config
COPY nvim /root/.config/nvim

# Bootstrap packer https://github.com/wbthomason/packer.nvim#bootstrapping
# https://github.com/wbthomason/packer.nvim/issues/599
# has some workaround in https://github.com/qwelyt/docker-stuff/commit/a41c2275e2311d3f6a5d53f7c4001999cd5005dd
# alternativeley we can just use silent to skip the prompt ...
# https://stackoverflow.com/questions/890802/how-do-i-disable-the-press-enter-or-type-command-to-continue-prompt-in-vim

RUN nvim --headless "+Lazy sync" +"sleep 15" +qa \
  && nvim --headless "+MasonInstall ${NEOVIM_LSP}" +"sleep 20" +qa 

# RUN nvim --headless \
#   -c "autocmd" \
#   -c "PackerComplete" \
#   -c "quitall" 
#
# RUN nvim --headless -c "PackerSync" \
#   -c "quitall"
#

#ENTRYPOINT nvim '+set clipboard=unnamed'
CMD nvim '+set clipboard=unnamed'
