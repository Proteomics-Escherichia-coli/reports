FROM bioconductor/bioconductor_docker:devel

# Set up the renv package
ENV RENV_VERSION 0.16.0
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# Set working directory
WORKDIR /home/rstudio/

COPY --chown=rstudio:rstudio . /home/rstudio/

# Copy the files and folder
COPY data /home/rstudio/data
COPY downstream_analysis /home/rstudio/downstream_analysis
COPY processing /home/rstudio/processing
COPY index.qmd index.qmd
COPY setup.R setup.R
COPY .gitignore .gitignore

# Copy the .lock file to the container
COPY renv.lock renv.lock

# Which library paths to use for package installation
ENV RENV_PATHS_LIBRARY renv/library

# Restore the packages defined in the lockfile
# RUN R -e "renv::restore()"
