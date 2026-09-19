# ellmer-sandpit

## bananarama slides

Experiment with [ellmer](https://ellmer.tidyverse.org/) and
[bananarama](https://hadley.github.io/bananarama/) to generate consistent
cartoony illustrations for presentation slides. The intended visual language is
friendly and playful, inspired by British early-reader picture books, while
using the GOV.UK colour palette and accessibility-conscious composition.

The aim is to create evocative illustrations that support a talk, not
AI-generated diagrams or text-heavy slide content. Keep slide text editable in
the presentation itself.

### Setup

1. Install R (already done in this container) and the package:

   ```r
   install.packages("pak")
   pak::pak("hadley/bananarama")
   ```

2. Set your API key as an environment variable (don't commit it):

   ```bash
   export GEMINI_API_KEY="your-key-here"
   # or, for OpenAI models:
   export OPENAI_API_KEY="your-key-here"
   ```

### Usage

Edit [bananarama.yaml](bananarama.yaml) to describe your slide images. The
`defaults.style` field is appended to every image's prompt, so put your overall
visual style there to keep a consistent look across the whole deck (this is the
approach described in
[Hadley Wickham's illustration workflow](https://tidydesign.substack.com/p/illustrating-my-slides-with-ai)).

The shared style should remain stable as individual image descriptions change:
use simple rounded cartoon forms, expressive poses, clear dark outlines, flat
colour blocking, and generous uncluttered space for slide text. Use GOV.UK
palette colour names rather than inventing a new palette. Do not ask the model
to reproduce named characters or copy a particular published illustration.

To add a recurring character (e.g. yourself), drop a reference image such as `hadley.png`
next to the YAML file, then reference it in a description with `[hadley]`.

When a prompt is working but the result varies too much, add `n: 3` (or another
small number) to the image entry to generate several candidates with the same
inputs.

Generate the images:

```bash
Rscript -e 'bananarama::bananarama("bananarama.yaml")'
```

Generated images are written to a directory named after the YAML file (e.g. `bananarama/`)
and are skipped on subsequent runs unless you pass `force = TRUE`.