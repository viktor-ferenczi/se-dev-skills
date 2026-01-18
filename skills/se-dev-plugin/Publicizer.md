# Krafs Publicizer

## Enabling Publicizer

If your code needs to access internal, protected or private members, then you likely want to enable the use of the Krafs publicizer in the project to avoid writing reflections. You can enable the publicizer by uncommenting the project file and C# code blocks marked with comments with "Uncomment to enable publicizer support" in them. Make sure not to miss any of those.

## Synchronization

If you use the Krafs publicizer, then make sure that the `<Publicize>` entries in the project file are ALWAYS in sync with the `IgnoresAccessChecksTo` entries in the C# code (`GameAssembliesToPublicize.cs` file).

## Handling Ambiguity Errors

If the plugin's build process reports ambiguity errors on the use of publicized symbols (typically events, but can be other symbols as well), then ignore those symbols from publicization by adding a `<DoNotPublicize>` entry for each of them in the project file.

## Documentation

Documentation of the Krafs publicizer: https://github.com/krafs/Publicizer