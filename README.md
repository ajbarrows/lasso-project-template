# Project Template for LASSO Sandbox (using R)

The purpose of this guide is to introduce a minimal, reproducible workflow for R-based data analysis projects. The priniciples can apply to most unix-based computational environments, but are specifically geared twoards users of the [LASSO Informatics NBDC Sandbox](https://nbdc.lassoinformatics.com/sandbox).

The Sandbox uses [Open OnDemand](https://www.openondemand.org), which is designed to be a GUI-based interface to high-performance computing (HPC). This particular instance of Open OnDemand offers several features:

1. Navigating file structures using a graphic interface
2. The ability to upload and download files
3. Submission of SLURM scripts for batch computing
4. A virtual Linux desktop
5. Instances of RStudio Server and Jupyter for interactively running R and Python code

Additionally, Lasso Informatics provides mounted access to the current tabular release of ABCD and HBCD data.

A much more comprehensive introduction to these resources can be found [here](https://nbdc.lassoinformatics.com/sandbox). Below are some suggestions for best practices, as well as possible solutions to problems you may encounter.

## Creating a project structure and mapping data

This repository is an example of a minimal R-based data analysis project:

```
project-template
├── .gitignore
├── data
│   ├── .gitkeep
│   ├── processed
│   │   └── .gitkeep
│   └── raw
│       └── .gitkeep
├── notebooks
│   └── .gitkeep
├── R
│   └── .gitkeep
└── README.md
```

- `README.md`: the file you're currently viewing
- `data`: where your project will read data from (`./data/raw`) and (optionally) write data to (`./data/processed`)
- `notebooks`: for exploratory data analysis (EDA) and model prototyping
- `R`: modules (i.e., functions, usually) that make up your analysis pipeline
- `scripts`: `R` and (optionally) `bash` scripts that serve as an entry point for reproducing your analyses. All code will eventually be run from here.


