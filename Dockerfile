FROM public.ecr.aws/lambda/nodejs:16
RUN yum -y update && \
    yum -y install \
    git tar unzip \
    libXScrnSaver gtk2 gtk3 alsa-lib.x86_64 alsa-lib-devel

RUN npx playwright install chromium

RUN curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
  && mkdir -p /usr/share/fonts/NotoSansCJKjp \
  && unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ \
  && rm NotoSansCJKjp-hinted.zip

ENTRYPOINT ["bash"]
