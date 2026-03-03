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


### First, clone this repository

**Important**: As of this writing, `git remote` functionality (i.e., interfacing to GitHub) only works via HTTPS. So, ensure you have copied the HTTPS URL for this repository. 

From a Linux desktop terminal or from within an instance of RStudio Server:

```{bash}
git clone https://github.com/ajbarrows/lasso-project-template.git
cd lasso-project-template
```

### Mapping data through symbolic links

The first necessary step is to create a link between where Lasso Informatics supplies data, and where your project will read it from. Can you get by through directly linking to the data source? Sure you can. Does it make your code reproducible? It does not.

To create a symbolic link, first change to the `./data/raw` directory from a terminal (this can be done from within RStudio Server or from a Linux desktop instance):

```{bash}
cd data/raw
```

As per the [sandbox guide](https://nbdc.lassoinformatics.com/sandbox), ABCD and HBCD data live at:

`/shared/abcd-6-0-release-tabulated-prod/`

and

`/shared/hbcd-1-0-release-tabulated-prod/`

respectively.

To create the link:

```{bash}
ln -s `/shared/{dataset-of-my-choice}-{release-number}-release-tabulated-prod/` .
```

Now, your project structure has changed slightly (ignoring hidden files):

```
.
├── data
│   ├── processed
│   └── raw
│       └── abcd-6-0-release-tabulated-prod
├── notebooks
├── R
├── README.md
└── scripts
```


Instead of reading your data from e.g., `/shared/abcd-6-0-release-tabulated-prod/`, you will now read it from `./data/raw/abcd-6-0-release-tabulated-prod`. 

As a concrete example, if you want to load the ABCD dynamic variables table (`ab_g_dyn`), you would do so as:

```{r}
fpath <- "./data/raw/abcd-6-0-release-tabulated-prod/ab_g_dyn.tsv"
df <- read.table(fpath, sep = "\t")
```
**Note**: This now a *relative* path. So, if you are working within the `/notebooks` directory, for example, your data path would need to "reach up" one level using `..`:

```{r}
fpath <- "../data/raw/abcd-6-0-release-tabulated-prod/ab_g_dyn.tsv"
df <- read.table(fpath, sep = "\t")
```


## Manage your environment

Since you're working with an externally-managed computational environment, you may encounter undesirable behaviors when installing R packages due to a lack of system-level dependencies. A commonly-accepted solution to this is [containerization](https://en.wikipedia.org/wiki/Containerization_(computing)). A fantastic group of people at the [Rocker Project](https://rocker-project.org) have created a collection of [Docker](https://www.docker.com) containers with clean installations of Ubuntu Linux and up-to-date versions of R already installed. 

The container implementation that works on the LASSO Sandbox is [Apptainer](https://apptainer.org), which is meant to be fully compatible with Docker containers. These containers work by defining a source (the Rocker Project), and a destination where the container will be built. Then you will perform your analyses from within that container. 

This repository comes with an example Apptainer "definition" file, `apptainer.def`. This definitions file installs necessary system libraries, an up-to-date version of R, and its own instance of RStudio (see below). To build it:

```{bash}
apptainer build project-container.sif apptainer.def 
```

**Note**: you can replace `project-container` with any name you like.

Then,

```{bash}
apptainer run project-container.sif
R
```

```{r}
install.packages(...)
```
