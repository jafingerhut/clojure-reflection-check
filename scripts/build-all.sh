#! /bin/bash

for clj_ver in \
    clojure-1.8.0 \
    clojure-1.9.0 \
    clojure-1.10.0 \
    clojure-1.10.1 \
    clojure-1.10.2-rc1 \
    clojure-1.10.2-rc2
do
    ./scripts/build.sh ${clj_ver} logs
done

