// original script by Jeffy
// modified by Xevrac: https://github.com/Xevrac/h2m_gscs/blob/main/h2m-mod/user_scripts/mp/bots_v2.1.gsc
// further modified by Logey: https://github.com/Logey/H2M-Bot-Manager

init() {
  setDvarIfUninitialized("bot_enabled", 1);
  botsEnabled = getDvarInt("bot_enabled");
  if (botsEnabled != 1) return;

  setDvarIfUninitialized(
    "bot_disabled_maps",
    // custom maps / individual ports
    "mp_stalingrad "  + "mp_haus "  +
    // mw2cr / h2m maps
    "airport "  + "cliffhanger "  + "contingency "  + "dcburning "  + "boneyard " + "gulag "  + "oilrig " + "estate " +
    "dc_whitehouse"
  );

  setDvarIfUninitialized("bot_quota", 12);

  setDvarIfUninitialized("bot_check_frequency", 1.0);

  level.currentMap = getDvar("mapname");

  level thread onPlayerConnect();
  self thread manageBots();
}

getDisabledMaps() {
  mapsDvar = getDvar("bot_disabled_maps");
  if (mapsDvar == "") return [];
  maps = strTok(mapsDvar, " ");
  return maps;
}

isMapDisabled(mapName) {
  maps = getDisabledMaps();
  if (!isDefined(maps) || maps.size == 0) return false;
  for (i = 0; i < maps.size; i++) {
    iMap = maps[i];
    if (iMap == mapName) return true;
  }
  return false;
}

onPlayerConnect() {
  while (1) {
    level waitTill("connected", player);
    player thread onPlayerSpawn();
  }
}

onPlayerSpawn() {
  self waitTill("spawned_player");

  if (isMapDisabled(level.currentMap)) {
    self tell("^1Bots are disabled on this map as they do not work.");
  }
}

manageBots() {
  if (isMapDisabled(level.currentMap)) {
    return;
  }
  level endOn("game_ended");
  level waitTill("prematch_over");
  botCheckFrequency = getDvarFloat("bot_check_frequency");
  botQuota = getDvarInt("bot_quota");
  while (1) {
    playerCount = level.players.size;
    if (playerCount < botQuota) {
      botsToAdd = botQuota - playerCount;
      for (i = 0; i < botsToAdd; i++) {
        executeCommand("spawnbot 1");
        wait 0.01;
      }
      continue;
    }
    if (playerCount > botQuota) {
      players = level.players;
      for (i = 0; i < players; i++) {
        iPlayer = players[i];
        if (isBot(iPlayer)) {
          kick(iPlayer getEntityNumber());
          botCheckFrequency = 0.5;
          break;
        }
      }
    }
    wait botCheckFrequency;
  }
}