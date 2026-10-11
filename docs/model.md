# Knowledge model and reasoning

## Class hierarchy

`Chemical`, `Acid`, `Base`, and `SewerNode` are abstract classes. Concrete classes are `StrongAcid`, `WeakAcid`, `StrongBase`, `WeakBase`, `Oil`, `Store`, `Manhole`, and `MonitoringStation`.

| Parent | Children |
| --- | --- |
| `Chemical` | `Acid`, `Base`, `Oil` |
| `Acid` | `StrongAcid`, `WeakAcid` |
| `Base` | `StrongBase`, `WeakBase` |
| `SewerNode` | `Manhole`, `MonitoringStation` |

Chemical slots describe names, formula, pH category and strength, solubility, spectroscopy, colour, smell, gravity, radioactivity, and hazards. Store relationships use `containsChemical` and `connectedManhole`; the `downstream` slot connects each manhole to its next sewer node.

## Assumptions

- A consultation describes one contaminating chemical from one store. Several chemicals can remain possible explanations; this does not model a mixture.
- Reported observations are reliable and every candidate must explain all of them. Omitted measurements impose no constraint.
- A reported spectroscopy element must occur in the chemical's modeled spectrum. A partial list does not exclude other unreported elements. `none` means no modeled element is detected.
- All routes lead to one monitoring station. Each store has one initial manhole, and each manhole has one downstream node. Routes may merge, but cycles and missing references are invalid.
- A polluted manhole lies on the source store's route to the station. Yes/no inspections filter the candidate stores using this assumption.
- Data follow the simplified coursework model. Chemical formulas marked `??` were unspecified in the original material and remain unspecified here.

## Numeric boundaries

| Observation | Category |
| --- | --- |
| `0 <= pH < 3` | Strong acid |
| `3 <= pH < 6` | Weak acid |
| `6 <= pH < 8` | Oil |
| `8 <= pH < 11` | Weak base |
| `11 <= pH <= 14` | Strong base |
| `0.9 <= gravity < 1` | Lighter than water |
| `gravity = 1` | Equal to water |
| `1 < gravity <= 1.1` | Heavier than water |

## Source localization

1. Match the observations against every `Chemical` instance.
2. Find all `Store` instances containing at least one matching chemical.
3. Follow `connectedManhole` and `downstream` links to obtain each store's route.
4. Consider each unasked `Manhole` instance and keep only those whose yes/no result would split the remaining stores into two nonempty groups.
5. Prefer the manhole nearest the monitoring station; then the most balanced split. A remaining tie uses the numeric suffix, when present, to preserve the example question order.
6. Apply the inspection answer and repeat until one store remains.
7. Intersect the candidate chemicals with the final store's contents and print their modeled hazards.

The search enumerates the current instances and follows their links. It does not scan a fixed range of store or manhole numbers, and arbitrary instance names are supported. If the remaining stores share indistinguishable routes, the system reports the remaining sources instead of repeating a question indefinitely.

## Editing the knowledge base

Update the Protégé `.pont` / `.pins` files and the embedded `defclass` / `definstances` sections of the CLIPS file together. The formats differ: the converted CLIPS classes use `slot` and `INSTANCE-NAME`, while the original Frames export uses `single-slot` and `INSTANCE` with Protégé annotations. Keep the dynamic solver below the static data.

After editing, run the automated checks. The instance consistency test compares every slot in all exported and embedded instances; failures identify a model copy that needs updating.
