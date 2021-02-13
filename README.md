# debian-texlive-ja
TeX Live Image for Japanese.

## Install

```
docker pull hisaboh/debian-texlive-ja
```

## Usage
```
$ docker run --rm -it \
    --mount type=bind,src=($pwd),dst=/workdir \
    --mount type=bind,src=/System/Library/Fonts,dst=/usr/share/fonts/SystemLibraryFonts \
    --mount type=volume,src=ltcache,dst=/usr/local/texlive/2020/texmf-var/luatex-cache \
    hisaboh/debian-texlive-ja \
    llmk document.tex
```

### mount
#### /workdir
This is your working directory.

#### /usr/share/fonts/SystemLibraryFonts
You can use Hiragino font If you are running docker on macOS.
To use Hiragino font, mount /System/Library/Fonts to /usr/share/fonts/SystemLibraryFonts, and set luatexja-preset.

```
\usepackage[hiragino-pron]{luatexja-preset}
```

#### /usr/local/texlive/2020/texmf-var/luatex-cache
Persistent font cache volume can makes compile faster.