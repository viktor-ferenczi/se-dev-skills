# ScriptDev Plugin for Space Engineers

This plugin automatically updates the code in programmable blocks
whenever the corresponding `Script.cs` changes. It is detected based
on the file's last modification time and polled every second.

Scripts of more than 100,000 characters can be loaded. This is useful
for offline development, but not compatible with multiplayer.

Please consider supporting my work on [Patreon](https://www.patreon.com/semods) or one time via [PayPal](https://www.paypal.com/paypalme/vferenczi/).

*Thank you and enjoy!*

## Prerequisites

- [Space Engineers](https://store.steampowered.com/app/244850/Space_Engineers/)
- [Pulsar](https://github.com/SpaceGT/Pulsar)

## Usage

Enable the **ScriptDev** plugin in Pulsar, apply the change and restart the game.

The name of the PB must include the script's name in square brackets.
For example: `Programmable Block [Name Of My Script]`

Script subdirectories also work, separate them by forward slashes.
For example: `Programmable Block [Script Subdir/Name Of My Script]`

Scripts are under this folder: `%AppData%\SpaceEngineers\IngameScripts\local`

Use the [In-game Script Merge Tool](https://github.com/viktor-ferenczi/se-script-merge)
for convenient in-game script development in a proper IDE. It allows for
merging your script from multiple files, sharing code between scripts,
introducing unit tests not copied into the script and minifying your 
script for release.

## Remarks

- This plugin is designed solely for local script development.
- It works only in offline and locally hosted games.
- It is not scalable to a large number of PBs.
