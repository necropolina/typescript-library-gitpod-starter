#!/bin/bash

yarn init

npx --yes json -I -f package.json -e "this.main=\"dist/bundle.cjs.js\""
npx json -I -f package.json -e "this.module=\"dist/bundle.es.js\""
npx json -I -f package.json -e "this.types=\"dist/bundle.d.ts\""

npx --yes npm-add-script -k build -v "tsc && yarn rollup -c"
npx npm-add-script -k lint -v "eslint src --fix"
npx npm-add-script -k test -v "jest --config jest.config.ts"
npx npm-add-script -k preversion -v "yarn test && yarn lint"
npx npm-add-script -k prepublishOnly -v "yarn test && yarn lint"
npx npm-add-script -k prepare -v "husky install"

npx json -I -f package.json -e "this['lint-staged']={'*.ts':[\"eslint --fix\",\"git add\"]}"

yarn add -D \
  typescript \
  ts-node \
  @types/node \
  jest \
  ts-jest \
  @types/jest \
  eslint \
  lint-staged \
  @typescript-eslint/eslint-plugin \
  @typescript-eslint/parser \
  husky \
  rollup \
  rollup-plugin-dts
  
npx husky install
