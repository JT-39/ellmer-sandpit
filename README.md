# ellmer-sandpit

## bananarama slides

Generate consistent-style slide background images using [bananarama](https://hadley.github.io/bananarama/), an R package that calls Google Gemini (or OpenAI) image models.

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

Edit [bananarama.yaml](bananarama.yaml) to describe your slide images. The `defaults.style`
field is appended to every image's prompt, so put your overall visual style there to keep
a consistent look across the whole deck (this is how Hadley keeps his slides looking uniform).

To add a recurring character (e.g. yourself), drop a reference image such as `hadley.png`
next to the YAML file, then reference it in a description with `[hadley]`.

Generate the images:

```bash
Rscript -e 'bananarama::bananarama("bananarama.yaml")'
```

Generated images are written to a directory named after the YAML file (e.g. `bananarama/`)
and are skipped on subsequent runs unless you pass `force = TRUE`.