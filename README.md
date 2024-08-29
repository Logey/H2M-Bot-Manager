# H2M-Bot-Manager
Server script to ensure there are always bots in the match. Allows you to disable bots on certain maps.

## DVARs
| DVAR                  | Default Value                                                                                                 | Description                                                                                                           |
|-----------------------|---------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `bot_enabled`         | 1                                                                                                             | Set to 0 to disable this script entirely on your server.                                                              |
| `bot_quota`           | 12                                                                                                            | The max amount of bots you want to have in your server.                                                               |
| `bot_check_frequency` | 1.0                                                                                                           | How often (in seconds) should the script check if it needs to add more bots, or kick a bot to make room for a player? |
| `bot_disabled_maps`   | "mp_stalingrad mp_haus airport cliffhanger contingency dcburning boneyard gulag oilrig estate dc_whitehouse"  | List of maps to disable bots on. These defaults are custom/ported maps that do not support bots.                      |