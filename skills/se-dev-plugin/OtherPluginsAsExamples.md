You can look into the source code of any other plugin registered on the `PluginHub` as examples, they are all open source.
Look into the `PluginHub` folder at the same directory level as this skill file is. It should have a `Plugins` 
subdirectory with XML files in it.

You can find the right plugins to look into by searching in the XML files in the `PluginHub\Plugins` folder,
they have `FriendlyName` and `Description` which should be enough to identify what they are about in most cases.
The `DotNetCompat` plugin is special (internal plugin), only use it if you want a good examples for preloader patch.

Each XML file corresponds to a plugin registered on the PluginHub. The `<RepoId>` (or if it is not present
then tha `Id`) field will tell you the GitHub repository ID of the plugin. Download the sources of the
plugin you want as ZIP and extract it. Read the source code of that plugin and use it as an example for your work.
ALWAYS extract the plugin sources under the `PluginSources` folder, which is next to this skill file,
then search their code from that location.