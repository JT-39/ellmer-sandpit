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

1. Install R and [`pak`](https://pak.r-lib.org/):

   ```r
   install.packages("pak")
   pak::pak("renv")
   ```

2. Restore the project environment from [renv.lock](renv.lock):

   ```r
   renv::restore()
   ```

The repository's `.Rprofile` activates the local `renv` environment when R
starts. Keep `renv.lock` committed so other machines can restore the same
package versions; the local `renv/library/` is intentionally ignored.

3. Set your API key as an environment variable (don't commit it):

   ```bash
   export GEMINI_API_KEY="your-key-here"
   # or, for OpenAI models:
   export OPENAI_API_KEY="your-key-here"
   ```

### Usage

Edit [bananarama.yaml](bananarama.yaml) to define the shared visual language.
The `defaults.style` field is appended to every image's prompt, so put the
overall style there to keep a consistent look across the whole deck (this is
the approach described in
[Hadley Wickham's illustration workflow](https://tidydesign.substack.com/p/illustrating-my-slides-with-ai)).

The shared style should remain stable as individual image descriptions change:
use simple rounded cartoon forms, expressive poses, clear dark outlines, flat
colour blocking, full-bleed compositions, and modest uncluttered space for
slide text. Use GOV.UK palette colour names rather than inventing a new
palette. Do not ask the model to reproduce named characters or copy a
particular published illustration.

To add a recurring character (e.g. yourself), drop a reference image such as `hadley.png`
next to the YAML file, then reference it in a description with `[hadley]`.

### Prompt design workflow

Use [demo.R](demo.R) as the main prompt-design loop. Edit the `description`
near the top of the script, then run:

```bash
Rscript demo.R --force
```

The script reads the shared style from `bananarama.yaml`, writes a temporary
ignored `demo.yaml` containing only the demo image, and generates output under
`demo/`. This keeps prompt experiments separate from the deck configuration.
Remove `--force` when you want to skip an existing demo image. When a prompt is
working but the result varies too much, set `candidates <- 3L` in the script
or copy the prompt into `bananarama.yaml` for the deck.

Generate all images defined in the deck directly with:

```bash
Rscript -e 'bananarama::bananarama("bananarama.yaml")'
```

Generated images are written to a directory named after the YAML file (e.g. `bananarama/`)
and are skipped on subsequent runs unless you pass `force = TRUE`.