---
name: se-dev-game-code
description: Allows reading the decompiled C# code of Space Engineers version 1.  
license: MIT
---
Follow these steps:
1. Do the one-time preparation steps described in `Prepare.md`, but only if the `Prepare.DONE` file is missing.
2. Conduct C# code search as needed for your task in the `Decompiled` folder.

How to search the game's code and content data:
- A Python virtual environment in this folder was made available by the preparation.
- Write short, reusable Python scripts to conduct custom code search. Strive for speed and minimal output. 
- Use `uv run script_name.py` in this folder (as CWD) to run your scripts.
- Python packages available (see `pyproject.toml` for the details if needed):
  - `lxml`
  - `tree-sitter` for C#, HLSL, JSON, Markdown, Python, XML
- In the `Decompiled` folder search only inside the C# source files (*.cs) in general. If you work on transpiler or preloader patches, then also search in the IL code (*.il) files.
- In the `Content` folder search the files appropriate for the task. See `ContentTypes.md` for the list of types.
