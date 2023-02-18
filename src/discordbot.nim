import dimscord, asyncdispatch, strutils, options
import tables, random, os
const token = ""
let discord = newDiscordClient(token)


proc onReady(s: Shard, r: Ready) {.event(discord).} =
    discard await discord.api.bulkOverwriteApplicationCommands(
        s.user.id,
        @[
            ApplicationCommand( # Just say who they high fived
                name: "Check gay",
                kind: atUser,
                default_permission: true
            ),
            ApplicationCommand( # Echo a message back
                name: "Resend",
                kind: atMessage,
                default_permission: true
            ),
            ApplicationCommand( # Echo a message back
                name: "test",
                kind: atSlash,
                description: "по приколу",
                default_permission: true
            )
        ]
    )

proc interactionCreate(s: Shard, i: Interaction) {.event(discord).} =
    let data = i.data.get
    var msg = ""
    if data.kind == atUser:
        for user in data.resolved.users.values: # Loop will only happen one
            msg &= "<@" & user.id & "> " & sample(@["is Gay <:pGay:1075805605090033756>", "is Natural"]) & "\n"
    elif data.kind == atMessage:
        for message in data.resolved.messages.values: # Same here
                msg &= message.content & "\n"
    elif data.kind == atSlash:
        msg = "Это жёска\n"

    await discord.api.interactionResponseMessage(i.id, i.token,
        kind = irtChannelMessageWithSource,
        response = InteractionCallbackDataMessage(
            content: msg
        )
    )

# Connect to Discord and run the bot.
waitFor discord.startSession()