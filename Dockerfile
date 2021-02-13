FROM debian:10-slim
LABEL maintainer="hisaboh@gmail.com"

ENV TL_VERSION=2020
ENV TL_PATH         /usr/local/texlive
ENV PATH            ${TL_PATH}/bin/x86_64-linux:/bin:${PATH}

WORKDIR /tmp

# Install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    # Basic tools
    wget unzip ghostscript \
    # for tlmgr
    perl-modules-5.28 \
    # for XeTeX
    fontconfig && \
    # Clean caches
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Install TeX Live
RUN mkdir install-tl-unx && \
    wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
      tar -xz -C ./install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "TEXDIR ${TL_PATH}" \
      "selected_scheme scheme-full" \
      "option_doc 0" \
      "option_src 0" \
      > ./install-tl-unx/texlive.profile && \
    ./install-tl-unx/install-tl \
      -profile ./install-tl-unx/texlive.profile && \
    rm -rf *

# Set up Japanese fonts
RUN tlmgr install \
      collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
      latexmk

# Install llmk
RUN wget -q -O /usr/local/bin/llmk https://raw.githubusercontent.com/wtsnjp/llmk/master/llmk.lua && \
      chmod +x /usr/local/bin/llmk

VOLUME ["/usr/local/texlive/${TL_VERSION}/texmf-var/luatex-cache"]
WORKDIR /workdir

CMD ["bash"]