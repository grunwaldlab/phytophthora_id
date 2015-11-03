**Phytophthora**-ID
===============

Repository for [Phytophthora ID](http://phytophthora-id.org), a [Microbe-ID](http://microbe-id.org) cutomized webpage for *Phytophthora* species. **Phytophthora-ID**is a web site designed for the identification of multiple *Phytophthora* species using common sequence barcodes (ITS and *cox* spacer) using BLAST searches against curated databases. **Phytophthora-ID** has an additional module to identify clonal lineages of *P. infestans* and *P. ramorum* using SSR markers.

We recommend the users/forkers to read the extensive documentation of the [Microbe-ID Github page](https://github.com/grunwaldlab/Microbe-ID) to udnerstand the construction and deployement of a custom Microbe-ID site.

Contents
-----------------
This repository contains the Bootstrap Twitter html pages of the Phytophthora-ID 2.0 webpage.

The site contains:
* An **Index** or  **Home** page
* A **Sequence-ID** page, which has the PERL-CGI BLAST capabilities to query unknown se quences against custom databases for *cox*-spacer or ITS reference databases
* The **Genotype-ID** front page and an iframe container, which permits the selection of Shiny R frameworks for genotyping isolates of two *Phytophthora* species, currently, *P. ramorum* and *P.infestans*
* An **About** page, containing all the information regarding collaborators, coauthors, and acknowledgments.
