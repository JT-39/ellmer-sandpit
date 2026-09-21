# Prompt-design loop:
# - Edit this description to test a scene.
# - Keep shared visual style and aspect ratio in bananarama.yaml.
# - Copy a successful description into the deck YAML when it is ready.
description <- paste(
  "Draw a picture of a person calmly overseeing a friendly factory full of",
  "robots typing at computers. Keep the scene simple, with one clear focal",
  "action and a balanced full-bleed composition across the entire 16:9 canvas.",
  sep = " "
)

source_yaml <- "bananarama.yaml"
# This generated file is ignored; it keeps experiments separate from the deck.
demo_yaml <- "demo.yaml"
# Pass --force to regenerate an existing image; omit it to reuse saved output.
force <- "--force" %in% commandArgs(trailingOnly = TRUE)
# Set this above 1 to compare several candidates for the same prompt.
candidates <- 1L

if (!requireNamespace("yaml", quietly = TRUE)) {
  stop("Install the yaml package before running this script.")
}
if (!requireNamespace("bananarama", quietly = TRUE)) {
  stop("Install bananarama before running this script.")
}

config <- yaml::read_yaml(source_yaml)
# Replace the deck images with one isolated prompt for faster iteration.
demo_image <- list(
  name = "demo-slide2",
  description = description
)
if (candidates > 1L) {
  demo_image$n <- candidates
}
config$images <- list(demo_image)
yaml::write_yaml(config, demo_yaml)

bananarama::bananarama(demo_yaml, force = force)
