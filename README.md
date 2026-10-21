# LaTeX Templates for Students @ UPB-CN

The UPB-CN group has a set of document templates prepared for students who participate in the teaching activities of the group. This repository contains all templates in LaTeX. For those who prefer [Typst](https://typst.app), please check [this repository](https://github.com/upb-cn/student-templates-typst).

Currently, the following templates are provided:
* Template for seminar report and review
* Template for BSc/MSc thesis proposal
* Template for BSc/MSc thesis

## Repository Structure

```
student-templates-latex/
├── seminar/
│   ├── report.tex          # Seminar report template
│   ├── review.tex          # Seminar peer review template
│   ├── refs.bib            # Bibliography file
│   └── upb-cn.cls, upb-logo.pdf
├── thesis-proposal/
│   ├── thesis-proposal.tex # Thesis proposal template
│   ├── refs.bib            # Bibliography file
│   └── upb-cn.cls, upb-logo.pdf
└── thesis/
    ├── thesis.tex          # Main thesis file
    ├── refs.bib            # Bibliography file
    ├── upb-cn.cls, upb-logo.pdf
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

Each template folder is self-contained: it holds its own copy of the document class (`upb-cn.cls`) and the logo (`upb-logo.pdf`). You can therefore copy or upload a single folder (e.g., to [Overleaf](https://www.overleaf.com)) and compile it on its own. The class is maintained centrally and updated in all folders at once; do not modify `upb-cn.cls`.

## How to Use the Templates

1. Clone the repository to your local directory:
```bash
git clone git@github.com:upb-cn/student-templates-latex.git
```

2. Navigate to the folder corresponding to your document type and edit the `.tex` file(s). You only need that one folder; it compiles on its own.

3. Each `.tex` file contains inline instructions explaining how to fill in the document. Each instruction is marked with a comment such as `% remove the following part in your report` (or `review`, `proposal`). Please follow the instructions closely and remove the marked text before submission.

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

Please follow these formatting conventions:

- **Citations:** use `\cite{key}` with entries managed by `biblatex`.
- **Lists:** use `itemize` or `enumerate`; do not nest deeper than two levels.
- **Inline code:** use `\verb+...+` or `\lstinline[language=...]|...|` for syntax highlighting.
- **Code blocks:** use the `lstlisting` environment with a `language=` option (supports C, Python, C++, etc.).
- **Tables:** use `booktabs` style (`\toprule`, `\midrule`, `\bottomrule`); avoid vertical bars; place captions *above* the table.
- **Figures:** place captions *below* the figure.
