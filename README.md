**Phytophthora**-ID
===============

Repository for [Phytophthora ID](http://phytophthora-id.org), a [Microbe-ID](http://microbe-id.org) cutomized web app for *Phytophthora* species. **Phytophthora-ID** is a web site designed for the identification of multiple *Phytophthora* species using common sequence barcodes (ITS and *cox* spacer) using BLAST searches against curated databases. **Phytophthora-ID** has an additional module built in R-Shiny to identify clonal lineages of *P. infestans* and *P. ramorum* using SSR markers.

We recommend the users/forkers to read the extensive documentation of the [Microbe-ID Github page](https://github.com/grunwaldlab/Microbe-ID) to understand the construction and deployement of a custom Microbe-ID site.

Contents
-----------------
This repository contains the Bootstrap Twitter html pages of the [Phytophthora ID](http://phytophthora-id.org) webpage.

**Phytopthora-ID** contains two main applications: **Sequence-ID** and **Genotype-ID**.

**Sequence-ID** allows identification of species by blasting a query sequence against a custom reference sequence database using BLAST. Sequence-ID has databases for the Internal Transcribed Spaces (ITS) region and the *cox* spacer.

**Genotype-ID** allows placement of an unknown genotype in either a minimum spanning network or dendrogram with bootstrap support comparing the queue against an user-created reference database using R and a suite of R packages designed for molecular markers. This version of Genotype-ID includes a modification of the [SSR-ID]() module optimized for clonal lineages of two *Phytophthora* species, currently, *P. ramorum* and *P.infestans*
