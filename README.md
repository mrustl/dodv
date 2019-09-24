[![Appveyor build Status](https://ci.appveyor.com/api/projects/status/github/mrustl/dodv?branch=master&svg=true)](https://ci.appveyor.com/project/mrustl/dodv/branch/master)
[![Travis build Status](https://travis-ci.org/mrustl/dodv.svg?branch=master)](https://travis-ci.org/mrustl/dodv)
[![codecov](https://codecov.io/github/mrustl/dodv/branch/master/graphs/badge.svg)](https://codecov.io/github/mrustl/dodv)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/dodv)]()

# dodv

Scrape and analyse year ranks lists of German
Opti-Dinghy Federation (DODV) available at:
<https://segler-rangliste.de/dodv>.

## Installation

For details on how to install KWB-R packages checkout our [installation tutorial](https://kwb-r.github.io/kwb.pkgbuild/articles/install.html).

```r
### Optionally: specify GitHub Personal Access Token (GITHUB_PAT)
### See here why this might be important for you:
### https://kwb-r.github.io/kwb.pkgbuild/articles/install.html#set-your-github_pat

# Sys.setenv(GITHUB_PAT = "mysecret_access_token")

# Install package "remotes" from CRAN
if (! require("remotes")) {
  install.packages("remotes", repos = "https://cloud.r-project.org")
}

# Install KWB package 'dodv' from GitHub

remotes::install_github("mrustl/dodv")
```

## Documentation

Release: [https://mrustl.github.io/dodv](https://mrustl.github.io/dodv)

Development: [https://mrustl.github.io/dodv/dev](https://mrustl.github.io/dodv/dev)
