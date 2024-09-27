# Comprehensive Analysis of Traffic Tickets Issued in Toronto

## Overview of the Paper

This paper attempts to identifying patterns in traffic violations to target areas and groups with elevated incidents. In particular, it explores the number of tickets issued around 2018-2023.

## File Structure

The repository is structured as follows:

data/raw_data contains the data sources used in analysis including the raw data. data/analysis_data contains the cleaned dataset that was constructed. other/llm contains the chat history with Chat-GPT4.0. other/sketches contains the original sketches (ie. graph, tables) made of the data. paper contains the files used to generate the paper, including the Quarto document, reference bibliography file, as well as the PDF of the paper. scripts contains the R scripts used to simulate, download and clean data.

## Reproducing Graphs and Tables

Here is a quick guide to reproducing my graphs and tables.

Clone this repository to your computer Download the data from OpenDataToronto using scripts/01-download_data.R Clean it using 02-data_cleaning.R Open TorontoTicketsIssued/paper/paper.qmd to test the R code that generated my plots.

## LLM Usage

An LLM, in particular Chat-GPT4.0, was used to aid in the writing of this paper. In particular, it was primarily used to aid with the coding aspect of the paper as opposed to the actual writing. The entire chat history can be found in other/llm/usage.txt.
