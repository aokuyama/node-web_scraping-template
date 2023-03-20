FROM public.ecr.aws/lambda/nodejs:16 as build

RUN npx playwright install chromium

RUN yum -y update && \
    yum -y install unzip

RUN curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
  && mkdir -p /usr/share/fonts/NotoSansCJKjp \
  && unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ \
  && rm NotoSansCJKjp-hinted.zip

WORKDIR /workspaces
COPY ./ ./

RUN npm install
ENV NODE_ENV=production
RUN npm run build


FROM public.ecr.aws/lambda/nodejs:16

RUN yum -y update && \
    yum -y install libXScrnSaver gtk2 gtk3 alsa-lib.x86_64 alsa-lib-devel
COPY --from=build /usr/share/fonts/NotoSansCJKjp /usr/share/fonts

WORKDIR ${LAMBDA_TASK_ROOT}
COPY --from=build /workspaces/dist/* ./
COPY --from=build /workspaces/node_modules/playwright-aws-lambda/dist/src/bin/ ./bin/

ENV NODE_ENV=production
CMD ["index.handler"]
