# Space Engineers Developer Skills

A [skill](https://code.claude.com/docs/en/skills) library for Space Engineers plugin, mod, and in-game script
development.

**This library applies only to version 1 of the game.**

## How to use

1. **Install [Claude Code](https://claude.com/product/claude-code).**
2. **Run it once** to ensure the `.claude` folder is created in your home directory: `%USERPROFILE%\.claude`.
3. **Clone this repository**
4. Run the link script corresponding to your agentic coding tool or link/move the skills manually:
   - Claude Code: `LinkIntoClaudeCode.bat`
   - Cline: `LinkIntoCline.bat`
   - Other: See below *

Claude should automatically detect these for new conversations. Please refer to the Claude documentation for more
details on using skills.

[*] You may be able to use these skills with other agentic coding tools than Claude Code and Cline.
Follow the instructions of your specific agentic coding tool on where to place global skills and links the
folders under `skills` in this repository there. You may customize one of the above batch files to do so and
make a PR with your batch file, so others can also use it.

## Preparation

Skills automatically prepare themselves on **first use** (downloading and indexing). If you want to prepare them ahead
of time, simply run `PrepareAllSkills.bat`. Alternatively run `Prepare.bat` inside each of the skill folders you want
to prepare. If some skill were messed up, just delete that skill folder, rollback from Git and prepare it again.
Also make sure to pull any updates to this repository, they may need to repeat the preparation on large changes.

**Note:** Preparing the `se-dev-game-code` skill may take 10–15 minutes, as it fully decompiles the game and builds code
indexes to allow for rapid code search later.

The fully prepared repository takes about **1.5 GB** of disk space due to the code index. If you need to save space, you
can delete all `*.il` files (approx. **660 MB**). These are only required for transpiler and preloader patch
development, advanced topics that are rarely needed.

## Skills

* [se-dev-script](https://www.google.com/search?q=skills/se-dev-script/SKILL.md) – In-game script development
* [se-dev-mod](https://www.google.com/search?q=skills/se-dev-mod/SKILL.md) – Mod development
* [se-dev-plugin](https://www.google.com/search?q=skills/se-dev-plugin/SKILL.md) – Plugin development
* [se-dev-game-code](https://www.google.com/search?q=skills/se-dev-game-code/SKILL.md) – Searchable decompiled C# game
  code

_Enjoy!_

---

## Want to know more?

- [SE Mods Discord](https://discord.gg/PYPFPGf3Ca) FAQ, Troubleshooting, Support, Bug Reports, Discussion
- [Pulsar Discord](https://discord.gg/z8ZczP2YZY) Everything about plugins

## FAQ

### How much of this was "vibe-coded"?

The `index_code.py` and `search_code.py` scripts were written entirely by Claude Code with zero human intervention,
other than repeated prompting and testing. The indexing logic is based on my previous work using Tree-sitter's C#
parser, originally developed for the (now defunct) *Ask Your Code* ChatGPT plugin and GPT.

### How well does this work for plugin development?

I am currently testing it myself. It looks promising, but there may be rough edges. Please try it out and report back or
submit a PR!

### Why do the mod development skills lack details about non-scripting parts?

I haven't developed many mods involving custom art or definitions, so I lack the personal experience to add those yet.
Contributions via PR are very welcome.

### Does Claude Code know about the mod and script API whitelists?

I have exported the current whitelists (as of game version 1.208.015) using [MDK2](https://github.com/malforge/mdk2).
This may need future updates or automation during the preparation phase.

If you use the suggested mod or script template projects and the **ScriptMerge** tool, there is no formal whitelist
validation during build time. It may fail when loading into the game, but if you provide the relevant game logs to
Claude Code, it can usually identify and fix the issue.

### How does Claude Code load this much information into the context?

It doesn't! Skills work on the principle of **"progressive disclosure."** Claude Code initially sees only the top-level
skill names and descriptions. It then gradually "discovers" more information as needed for the task. It has been given
specific instructions on how to search the SE codebase efficiently so it doesn't get overwhelmed.

Ideally, it performs research using sub-agents and clears irrelevant data before passing the results back to the parent
agent. Agent hierarchies are a fascinating and fast-evolving topic, definitely worth looking into!

## Troubleshooting

If you suspect something is not working in these skills, then issue the following test prompt in an empty project:

```md
Check whether you can see these skills:
- `se-dev-script`
- `se-dev-mod`
- `se-dev-plugin`
- `se-dev-game-code`

If you see them, then make sure they're prepared for first use.

Once they are prepared, conduct some smoke testing on their features to make sure they work.

If something is missing or not working properly, then list those for me.
```

## Successful self-test result

All four skills are visible and prepared for first use.

### All Skills Working

| Skill | Status | Key Features Verified |
|-------|--------|----------------------|
| **se-dev-script** | ✅Ready | Preparation complete, ModApiWhitelist.txt available, Python 3.13.2 via uv |
| **se-dev-mod** | ✅Ready | SteamMods symlink working, LocalMods symlink working, Python 3.13.2 via uv |
| **se-dev-plugin** | ✅Ready | All documentation (Plugin.md, Guide.md, Patching.md, etc.) accessible, Python 3.13.2 via uv |
| **se-dev-game-code** | ✅Ready | Decompiled/ folder with game assemblies, Content/ folder, CodeIndex/ with CSV indexes, code search working |

### Nothing Missing or Broken

All skills have:
- `Prepare.DONE` file present (preparation completed)
- Python 3.13.2 working via `uv run`
- Required resources accessible (symlinks, documentation, indexes)
- Code search/indexing functional

---

## Credits

### Patreon Supporters

_in alphabetical order_

#### Admiral level

- BetaMark
- Casinost
- Mordith - Guardians SE
- Robot10
- wafoxxx

#### Captain level

- Diggz
- jiringgot
- Jimbo
- Kam Solastor
- lazul
- Linux123123
- Lotan
- Lurking StarCpt
- NeonDrip
- NeVaR
- opesoorry

#### Testers

- Avaness
- mkaito

### Creators

- Space - Pulsar
- avaness - Plugin Loader (legacy)
- Fred XVI - Racing maps
- Kamikaze - M&M mod
- LTP
- Mordith - Guardians SE
- Mike Dude - Guardians SE
- SwiftyTech - Stargate Dimensions

**Thank you very much for all your support!**

### Legal

Space Engineers is trademark of Keen Software House s.r.o.
