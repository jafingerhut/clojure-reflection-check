# Introduction

A few bash scripts to build several versions of Clojure from source
code, after patching them to enable reflection warnings in all .clj
source files, and summarize the results.

To run it on several recent Clojure versions:

```bash
./scripts/build-all.sh
```

To run it an individual version of Clojure, pick one of these command
lines:

```bash
./scripts/build.sh clojure-1.8.0 logs
./scripts/build.sh clojure-1.9.0 logs
./scripts/build.sh clojure-1.10.0 logs
./scripts/build.sh clojure-1.10.1 logs
./scripts/build.sh clojure-1.10.2-rc1 logs
```
