# Code Search Guide

## Index Files

Located in `CodeIndex/` folder after preparation:

| Index File | Contains | Use For |
|------------|----------|---------|
| `namespaces.csv` | Namespace declarations | Finding which assembly defines a namespace |
| `interfaces.csv` | Interface declarations and usages | Finding interface definitions and implementations |
| `classes.csv` | Class declarations and usages | Finding class definitions and references |
| `structs.csv` | Struct declarations and usages | Finding struct definitions and references |
| `enums.csv` | Enum declarations and usages | Finding enum definitions and references |
| `methods.csv` | Method declarations and usages | Finding method signatures and call sites |
| `variables.csv` | Fields, properties, locals | Finding variable definitions and references |

## CSV Column Structure

All index files share this structure:

```
namespace,containing_type,method,variable_name,type,file_path,start_line,end_line,description
```

- `namespace` - The namespace containing the symbol
- `containing_type` - The class/struct/interface containing the symbol
- `method` - The method containing the symbol (empty for type-level declarations)
- `variable_name` - Variable/field/property name (for variables.csv)
- `type` - Either `declaration` or `usage`
- `file_path` - Relative path from `Decompiled/` folder
- `start_line`, `end_line` - Line range in source file
- `description` - XML doc comment summary (for declarations)

## The `type` Column

This is the most important column for efficient searching:

- **`declaration`** - The actual definition of a type/method/variable
- **`usage`** - A reference to the symbol from elsewhere in the code

Always filter by `type` to get relevant results quickly.

## Finding Declarations

To find where something is **defined**, filter for `declaration`:

```bash
# Find struct declaration
grep ",Vector3D," CodeIndex/structs.csv | grep ",declaration,"

# Find class declaration
grep ",MyToolbar," CodeIndex/classes.csv | grep ",declaration,"

# Find interface declaration
grep ",IMyTerminalBlock," CodeIndex/interfaces.csv | grep ",declaration,"

# Find enum declaration
grep ",MyRelationsBetweenPlayerAndBlock," CodeIndex/enums.csv | grep ",declaration,"

# Find method declaration (all overloads)
grep ",GetPosition," CodeIndex/methods.csv | grep ",declaration,"

# Find method in specific class
grep ",MyEntity,GetPosition," CodeIndex/methods.csv | grep ",declaration,"
```

## Finding Usages

To find where something is **used**, filter for `usage`:

```bash
# Find all usages of a class
grep ",MyToolbar," CodeIndex/classes.csv | grep ",usage,"

# Find all calls to a method
grep ",GetPosition," CodeIndex/methods.csv | grep ",usage,"

# Find usages of a method from a specific class
grep ",MyEntity,GetPosition," CodeIndex/methods.csv | grep ",usage,"
```

## Using search_code.py

The `search_code.py` script provides pagination and pattern matching:

```bash
uv run python search_code.py <index_file> <max_results> <offset> <pattern>
```

### Pattern Modes

- **Simple text** (default): Case-insensitive substring match
  ```bash
  uv run python search_code.py CodeIndex/classes.csv 20 0 MyToolbar
  ```

- **Exact match**: Case-sensitive exact match (prefix with `exact:`)
  ```bash
  uv run python search_code.py CodeIndex/structs.csv 20 0 "exact:Vector3D"
  ```

- **Regex**: Regular expression (prefix with `re:`)
  ```bash
  uv run python search_code.py CodeIndex/classes.csv 20 0 "re:^My.*Block$"
  ```

### Combining with grep for declarations/usages

```bash
# Find declaration with search_code.py
uv run python search_code.py CodeIndex/structs.csv 100 0 "exact:Vector3D" | grep ",declaration,"

# Find usages with pagination
uv run python search_code.py CodeIndex/methods.csv 50 0 GetPosition | grep ",usage,"
```

## Common Search Patterns

### Find a type definition

```bash
# Quick: use grep directly
grep ",TypeName," CodeIndex/classes.csv | grep ",declaration,"

# With description/docs
uv run python search_code.py CodeIndex/classes.csv 10 0 "exact:TypeName" | grep ",declaration,"
```

### Find all members of a class

```bash
# All methods
grep ",MyClassName," CodeIndex/methods.csv | grep ",declaration,"

# All fields/properties
grep ",MyClassName," CodeIndex/variables.csv | grep ",declaration,"
```

### Find implementations of an interface

```bash
# First find the interface
grep ",IMyInterface," CodeIndex/interfaces.csv | grep ",declaration,"

# Then find classes that reference it (potential implementers)
grep ",IMyInterface," CodeIndex/classes.csv | grep ",usage,"
```

### Find method call sites

```bash
# All calls to MethodName anywhere
grep ",MethodName," CodeIndex/methods.csv | grep ",usage,"

# Calls to ClassName.MethodName specifically
grep ",ClassName,MethodName," CodeIndex/methods.csv | grep ",usage,"
```

### Find where a variable is used

```bash
grep ",variableName," CodeIndex/variables.csv | grep ",usage,"
```

## Reading Source Files

After finding a declaration, read the source:

```bash
# From search result: file_path=VRage.Math\VRageMath\Vector3D.cs, start_line=13
# Read the file at: Decompiled/VRage.Math/VRageMath/Vector3D.cs
```

The `Decompiled/` folder contains the full decompiled source organized by assembly.

## Tips

1. **Start with declarations** - Filter `,declaration,` first to find definitions
2. **Use exact match for common names** - Avoid `Vector` matching `Vector2`, `Vector3`, `Vector3D`, etc.
3. **Check the assembly** - The first folder in `file_path` indicates which game DLL contains the code
4. **Use grep for speed** - Direct grep is faster than search_code.py for simple lookups
5. **Use search_code.py for pagination** - When you expect many results and need to browse them

## Assembly Reference

Common assemblies in the decompiled code:

| Assembly | Contains |
|----------|----------|
| `VRage.Math` | Math types: Vector3, Matrix, BoundingBox, etc. |
| `VRage.Game` | Game definitions, object builders |
| `VRage.Library` | Core utilities |
| `Sandbox.Game` | Game logic, entities, blocks |
| `Sandbox.Common` | Shared game code |
| `SpaceEngineers.Game` | SE-specific game code |
| `SpaceEngineers.ObjectBuilders` | SE save data structures |
