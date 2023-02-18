# Package
version       = "0.0.1"
author        = "levshx"
description   = "Discord bot"
license       = "MIT"
srcDir        = "src"
bin           = @["discordbot"]


# Dependencies

requires "dimscord >= 1.4.0"

task dev, "Run dev version":
  exec "nim c --nimcache:\"temp\" -o:\"bin/discordbot\" -r ./src/discordbot.nim "
