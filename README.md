# typst-math Extension For Quarto

This extension converts the default LaTeX math blocks in Pandoc to Typst math blocks. This allows you to write Typst math inside inline Pandoc math (`$...$`) and Pandoc display math (`$$ ... $$`).

Thank you very much to @cderv for providing the foundation of the lua filter. Here, I'm mostly packaging it.

## Installing

```bash
quarto add sverrirarnors/typst-math
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Simply add the typst-math filter in your yaml header:

```yaml
---
title: "`typst-math` Example"
format: typst
filters:
  - typst-math
---
```

and then use typst math within either inline math or display math. Note that for display math, you need to add a new line after the `$$`, like so:

```
$$
[math here]
$$
```

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd), and the output [example.pdf](example.pdf).
