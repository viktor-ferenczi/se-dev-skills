# Harmony Patching

- The patching library used is Harmony, also called HarmonyLib.
- Harmony allows for changing the IL code of the game at runtime, after the game's assemblies (DLLs) are already loaded into memory.
- Harmony patches are applied on loading the game.
- Before writing a plugin with patches, consider whether the implementation is possible as a Programmable Block script (PB API) or a mod (Mod API). (Usually it is not if writing a plugin comes up as a solution.)
- Writing prefix and suffix patches is usually the way to go to change the game's internals. However, some changes can be done by using the same API as mods or even Programmable Block script. It depends on the usage.
- If you need to change something in the middle of a long method, where none of the prefix and postfix patching are useful, then you may use a transpiler patch at the cost of additional complexity: [TranspilerPatching.md](TranspilerPatching.md)
- If you need to change IL code before JIT compilation, then you must use a preloader patch. See [PreloaderPatching.md](PreloaderPatching.md)

# References

- Full Harmony documentation: https://harmony.pardeike.net/articles/intro.html
