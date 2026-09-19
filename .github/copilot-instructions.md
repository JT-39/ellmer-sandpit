# Copilot instructions

## Project purpose and architecture

This repository is a small, configuration-driven image-generation playground
for experimenting with `ellmer` and `bananarama`. Its goal is to produce a
reusable set of friendly, cartoony illustrations for presentation slides. The
intended visual direction is similar to the clarity and warmth of British
early-reader picture books, while remaining an original visual language and
not reproducing named characters or published artwork.

The tracked YAML file is the source of truth for a slide deck:

1. `bananarama.yaml` defines global image defaults and a list of named images.
2. The `bananarama` R package reads that YAML and calls a configured image model
   through Google Gemini or OpenAI.
3. Generated images are written under `bananarama/`, using the YAML filename as
   the output directory name.

There is no application runtime or local source package in this repository.
Changes should normally be made to the YAML content and documentation rather
than by adding code. Generated images and local credentials are intentionally
ignored by Git.

## Setup and commands

Install the package once from R:

```r
install.packages("pak")
pak::pak("hadley/bananarama")
```

Configure one provider key in the environment, without committing it:

```bash
export GEMINI_API_KEY="your-key-here"
# or:
export OPENAI_API_KEY="your-key-here"
```

Generate the configured images from the repository root:

```bash
Rscript -e 'bananarama::bananarama("bananarama.yaml")'
```

Existing output files are skipped. Force regeneration with:

```bash
Rscript -e 'bananarama::bananarama("bananarama.yaml", force = TRUE)'
```

There are currently no repository-defined build, test, or lint commands. To
exercise a single image, use a temporary YAML file containing only that image
and run the same generation command against that file; do not add generated
output to the repository.

## YAML conventions

- Put the deck-wide visual language in `defaults.style`; `bananarama` appends
  this text to every image prompt.
- Keep the shared style consistent with the project goal: simple rounded
  cartoon forms, expressive poses, clear dark outlines, flat colour blocking,
  restrained texture, and generous whitespace for editable slide text.
- Use the GOV.UK web palette and its tints/shades as the colour vocabulary.
  Prefer dark charcoal or black for outlines and text, use sufficient contrast
  between foreground and background, and do not rely on colour alone to convey
  meaning. GOV.UK's minimum target for text and interactive content is WCAG 2.2
  AA contrast.
- Avoid putting important wording, labels, or diagrams inside generated images:
  generated text is unreliable and slide text should remain editable. Describe
  the visual idea and reserve clear space for text in the presentation.
- Keep the global `defaults.aspect-ratio` aligned with the slide format (the
  current deck uses `"16:9"`).
- Each entry under `images` needs a stable `name` and a natural-language
  `description`. The name determines the generated asset's identity, so avoid
  casually renaming existing entries.
- Use YAML's folded scalar style (`>`) for multi-line style and descriptions so
  prompts remain readable while being passed as normal text.
- Reference a recurring character or subject image by placing the reference
  image beside the YAML file and using the package's bracket syntax, such as
  `[hadley]`, in an image description.
- Use `n: 3` or another small value when several candidates are useful for
  comparing the same prompt and seed variation.
- Keep generated files under `bananarama/` and credentials in `.Renviron`;
  both are ignored by `.gitignore`.

## Documentation

Keep `README.md` synchronized with changes to setup, provider configuration,
generation commands, output behavior, or the YAML schema. `bananarama.yaml`
should remain a usable example when changing its structure or conventions.
