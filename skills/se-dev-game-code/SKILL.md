---
name: se-dev-game-code
description: Allows reading the decompiled C# code of Space Engineers version 1.  
license: MIT
---
If the `Prepare.DONE` file is missing, then start by following the steps in `Prepare.md` first.

Use the code search if you need to know more about the game's internal by reading its decompiled C# code.
Read `CodeSearch.md` for detailed information on code search and its best practices, including example commands.
Always check the game code if you are unsure about its internal APIs and want to know how to interface with them
properly. Also check the game code if you want to understand existing mod, script or plugin code or the inner
workings of some Space Engineers data type is unclear.

A Python virtual environment in this folder was made available by the preparation, you can use that.
Use `uv run script_name.py` in this folder (as CWD) to run your scripts.
Python packages available (see `pyproject.toml` for the details if needed):
- `lxml` for XML parsing and processing
- `requests` to make HTTP requests, useful to download files
- `tree-sitter` for C#, HLSL, JSON, Markdown, Python, XML

The textual part of the game's `Content` is copied into the `Content` folder, so you can use free text search in it:
- Language translations, including the string IDs
- Block and other entity definitions
- Default blueprints and scenarios

General rules:
- Use `busybox bash` to open a bash shell, which you can use easier, because it is close to UNIX.
- Alternatively use the Windows PowerShell if busybox would not work for something.
- On the Windows command line (cmd) (NOT on busybox!) use the `&` delimiter commands instead of `&&`.
- In the `Decompiled` folder search only inside the C# source files (*.cs) in general. If you work on transpiler or preloader patches, then also search in the IL code (*.il) files.
- In the `Content` folder search the files appropriate for the task. See `ContentTypes.md` for the list of types.
- Do not search for decompiled game code outside the `Decompiled` folder which is at the same level as this skill file. The decompiled game source tree must be there is the preparation succeeded.
- Do not search for game content data outside the `Content` folder which is at the same level as this skill file. The copied game content must be there is the preparation succeeded.
