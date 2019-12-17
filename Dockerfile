FROM ubuntu:18.04 AS download-files

RUN apt-get update && apt-get install -y
    wget \

WORKDIR /src

RUN wget -O jlisting.sty.bz2 https://osdn.net/frs/redir.php?m=jaist&f=mytexpert%2F26068%2Fjlisting.sty.bz2
RUN bunzip jlisting.sty.bz2

FROM paperist/alpine-texlive-ja


RUN tlmgr update --self --all \
    && tlmgr install siunitx
RUN apk --no-cache add libxaw-dev

COPY --from=download-files /src/jlisting.sty /usr/local/texlive/2019/texmf-dist/tex/latex/listings/

COPY .latexmkrc /root/

ENTRYPOINT [ "latexmk" ]
