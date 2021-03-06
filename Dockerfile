FROM rocker/verse:3.6.1
# OS: Debian GNU/Linux 9 (stretch)


# For adding metadata to pdfs
RUN apt-get update && apt-get install -y pdftk
RUN apt-get clean


# Adding common R Packages that aren't in rocker/verse
RUN R -e "devtools::install_version('pzfx', version = '0.2.0', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_version('checkmate', version = '1.9.4', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_version('BiocManager', version = '1.30.9', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_version('cowplot', version = '1.0.0', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_version('ggrepel', version = '0.8.1', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_version('pryr', version = '0.1.4', repos = 'http://cran.us.r-project.org')"
RUN R -e "BiocManager::install('DESeq2')" # couldn't find how to get a specific verions for this
RUN R -e "devtools::install_github('jokergoo/ComplexHeatmap', ref = '1.99.4')"


# This script ensures the rserver shuts down all of its processes when nologer active.
COPY /rserver_handler.sh /rserver_handler.sh
RUN chmod ugo+x /rserver_handler.sh


ENTRYPOINT ["/rserver_handler.sh"]