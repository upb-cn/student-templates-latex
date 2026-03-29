# LaTeX Templates for Students @ UPB-CN

The UPB-CN group has a set of document templates prepared for students who participate in the teaching activities of the group. This repository contains all templates in LaTeX. For those who prefer [Typst](https://typst.app), please check [this repository](https://github.com/upb-cn/student-templates-typst).

Currently, the following templates are provided:
* Template for seminar report and review
* Template for BSc/MSc thesis proposal
* Template for BSc/MSc thesis

## Repository Structure

```
student-templates-latex/
├── upb-cn.cls              # Shared document class for all templates
├── upb-logo.pdf            # UPB-CN logo used in the class
├── template-tutorial.tex   # Writing tutorial included in each template
├── seminar/
│   ├── report.tex          # Seminar report template
│   ├── review.tex          # Seminar peer review template
│   └── refs.bib            # Bibliography file
├── thesis-proposal/
│   ├── thesis-proposal.tex # Thesis proposal template
│   └── refs.bib            # Bibliography file
└── thesis/
    ├── thesis.tex          # Main thesis file
    ├── refs.bib            # Bibliography file
    ├── pretext/
    │   ├── titlepage.tex   # Title page (do not modify)
    │   ├── copyright.tex   # Copyright page (do not modify)
    │   └── legal.tex       # Legal declaration (do not modify)
    └── text/
        ├── abstract.tex
        ├── acknowledgement.tex
        ├── introduction.tex
        ├── background.tex
        ├── design.tex
        ├── evaluation.tex
        ├── discussion.tex
        └── conclusion.tex
```

## How to Use the Templates

1. Clone the repository to your local directory:
```bash
git clone git@github.com:upb-cn/student-templates-latex.git
```

2. Navigate to the folder corresponding to your document type and edit the `.tex` file(s). **Do not change the directory structure** — the class file and tutorial are referenced by relative paths.

3. Each `.tex` file contains inline instructions explaining how to fill in the document. Please follow the instructions closely and remove the instruction text before submission.

4. Add your references to the `refs.bib` file in the respective folder. It is recommended to collect bib entries from [DBLP](https://dblp.org).

## Building the Documents

A `Makefile` is provided for convenience. You need `latexmk` installed (included in most TeX distributions such as TeX Live or MiKTeX).

| Command | Description |
|---|---|
| `make report` | Compile the seminar report |
| `make review` | Compile the seminar peer review |
| `make seminar` | Compile both seminar report and review |
| `make thesis-proposal` | Compile the thesis proposal |
| `make thesis` | Compile the thesis |
| `make all` | Compile all documents |
| `make clean` | Remove all generated files |

## Template Details

### Seminar (`seminar/`)

There are two documents for seminar participation:

- **`report.tex`** — The seminar report. It follows a fixed structure: Abstract, Introduction, Background, Problem Statement and Taxonomy, Summary of Surveyed Papers, Qualitative Analysis and Comparison, Comments on the Papers, and Conclusions. 

- **`review.tex`** — The peer review of another student's report (1–2 pages). It follows a fixed structure: Summary of the Paper, Strengths, Areas for Improvement, and Detailed Comments. 

### Thesis Proposal (`thesis-proposal/`)

**`thesis-proposal.tex`** is used to propose your BSc or MSc thesis project. It contains the following sections:

- **Introduction** — Background, motivation, and a summary of expected contributions.
- **Research Objectives** — The overarching research question divided into 2–4 concrete objectives.
- **Related Work** — Overview of existing work, direct competitors, and the gap your thesis addresses.
- **Proposed Work** — Approaches, techniques, and evaluation plan. Preliminary results are strongly encouraged.
- **Timeline** — A required Gantt chart spanning your thesis duration, plus a milestone table.

### Thesis (`thesis/`)

**`thesis.tex`** is the main file for a BSc or MSc thesis. Fill in the metadata at the top (title, author, degree, second reviewer, supervisors, submission date) and then write your content in the files under `text/`:

- `acknowledgement.tex` — Acknowledgements.
- `abstract.tex` — Abstract.
- `introduction.tex` — Introduction chapter.
- `background.tex` — Background chapter.
- `design.tex` — System/approach design chapter.
- `evaluation.tex` — Evaluation chapter.
- `discussion.tex` — Discussion chapter.
- `conclusion.tex` — Conclusion chapter.

The `pretext/` files (title page, copyright, legal declaration) are generated automatically from the metadata and should not be modified.

## Writing Tips

The `template-tutorial.tex` file (included in all templates) demonstrates the formatting conventions:

- **Citations:** use `\cite{key}` with entries managed by `biblatex`.
- **Lists:** use `itemize` or `enumerate`; do not nest deeper than two levels.
- **Inline code:** use `\verb+...+` or `\lstinline[language=...]|...|` for syntax highlighting.
- **Code blocks:** use the `lstlisting` environment with a `language=` option (supports C, Python, C++, etc.).
- **Tables:** use `booktabs` style (`\toprule`, `\midrule`, `\bottomrule`); avoid vertical bars; place captions *above* the table.
- **Figures:** place captions *below* the figure.