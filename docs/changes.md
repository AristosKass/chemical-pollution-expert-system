# Preparation for the public repository

The original files were a joint university submission with a Protégé Frames project, a CLIPS solver, and a one-page Greek ontology report. This package preserves their structure and authorship. The original uploaded files were left untouched.

## Corrections

- Renamed the three ontology files to `pollution.pprj`, `pollution.pont`, and `pollution.pins`, and corrected the project references to these actual filenames.
- Changed `aluminium_hydroxide.spectroscopy` from `none` to `metal` in both the Protégé instances and the CLIPS data, following the coursework description.
- Used strict comparisons against 1.0 for specific gravity. The original solver treated values within 0.0001 of 1.0 as equal, which differed from the stated boundaries.
- Rejected contradictory spectroscopy input such as `none metal`, rather than silently replacing it with `none`.
- Retried the whole measurement list when it contains an invalid name, rather than silently discarding that name.
- Added clean end-of-input handling to prevent repeated prompts on exhausted input.
- Added drainage validation for cycles, missing nodes, missing chemical references, invalid store connections, and the single monitoring station.
- Replaced the repeated fallback question for indistinguishable stores with a clear ambiguity result.

The initial solver already passed the three required example consultations. The public version retains their chemical results, source stores, and manhole question order.

## Presentation and privacy

- Added an English README, input examples, a drainage diagram, model notes, an ignore file, and executable tests.
- Preserved both authors' names; removed student identifiers from source comments and the report. Removed PDF metadata from the public report copy.
- Included the authors' report and implementation files. The supplied assignment briefs are not part of this repository package.

## Validation

- Loaded and executed the CLIPS file with clipspy 1.0.6 and its bundled CLIPS 6.4.2 engine.
- Passed 23 unittest cases, including the three required consultations, identification of every chemical, boundary values, invalid inputs, end of input, invalid graphs, ambiguous routes, and an additional warehouse with arbitrary names.
- Compared all 32 Protégé instance definitions against the embedded CLIPS instances.
- Checked `.pprj` references, relative documentation links, package contents, and removal of student identifiers from text and the PDF.
- The Protégé 3.5 graphical editor was not run; its project files were checked structurally and against the exported CLIPS data.
