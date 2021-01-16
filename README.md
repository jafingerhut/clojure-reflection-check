# Introduction

A few bash scripts to build several versions of Clojure from source
code, after patching them to enable reflection warnings in all `.clj`
source files, and summarize the results.

Requires installations of these commands:
+ `git`
+ `java` command from JDK 8 or later
+ `mvn` command of Apache Maven

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
./scripts/build.sh clojure-1.10.2-rc2 logs
```

The output files with names having the pattern
`summary-clojure-<version>.txt` in the `logs` directory are intended
to be compared across different Clojure versions, when run using the
same version of the JDK.

When using different JDK versions, there are many warning messages
that typically appear with some JDK versions, but not others.  Those
may be of interest if you are trying to determine whether there might
be ways to change the Clojure implementation to eliminate some of
those warnings with recent JDK versions, but note that the Clojure
core team is much more likely to be interested in doing so if they are
signs of actual bugs in the Clojure implementation, and not only
warnings.
