# Package
version       = "0.0.1"
author        = "levshx"
description   = "Discord bot"
license       = "MIT"
srcDir        = "src"
bin           = @["discordbot"]


# Dependencies

requires "dimscord >= 1.4.0"

import os

task dev, "Run dev version":
  if not fileExists("discord.key"):
    writeFile("discord.key", "---PASTE DISCORD OAUTH HERE---")
    echo "PASTE DISCORD OAUTH IN discord.key"
  else:
    exec "nim c --nimcache:\"temp\" -o:\"bin/discordbot\" -r ./src/discordbot.nim "
