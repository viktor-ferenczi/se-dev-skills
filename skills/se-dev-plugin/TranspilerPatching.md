# Transpiler patches

Transpiler patches are executed only once to rewrite the IL code of a specific method.
Therefore, the transpiler patches themselves cannot depend on the runtime state.

Writing pre-patches or transpiler patches is harder because they depend on the IL code from the 
original game assemblies, which can only be obtained while running the game or by decompiling the game DLLs. 
Use transpiler patches only if absolutely required.

Transpiler patches can be best understood by logging the original and modified IL code in separate files. 
This can be done by the `RecordOriginalCode` and `RecordPatchedCode` methods of the `TranspilerHelpers` class. 
However, capturing IL code requires running the game to capture this information. 
Use it wisely, ask the developer for assistance with running the game to get to the original IL code and 
to verify your changes. Writing transpiler patches requires systematic iteration. 

Never extend the plugin's `Init` method with explicit `harmony.Patch` calls. 
It is enough to decorate the static patch classes with `[HarmonyPatch]` or `[HarmonyPatch(type(ClassToPatch))]`, 
then properly write its members.