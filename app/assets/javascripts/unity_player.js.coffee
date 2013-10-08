$ ->
  config =
    width: 960,
    height: 600,
    params:
      enableDebugging: "0"
  u = new UnityObject2 config

  $missingScreen = $("#unityPlayer").find(".missing")
  $brokenScreen = $("#unityPlayer").find("broken")
  filename = $("#unity_file").val()
  $missingScreen.hide
  $brokenScreen.hide
  u.observeProgress (progress) ->
    if progress.pluginStatus == "broken"
      $brokenScreen.find("a").click (e) ->
        e.stopPropagation
        e.preventDefault
        u.installPlugin
      $brokenScreen.show
    else if progress.pluginStatus == "missing"
      $missingScreen.find("a").click (e) ->
        e.stopPropagation
        e.preventDefault
        u.installPlugin
      $missingScreen.show
    else if progress.pluginStatus == "installed"
      $missingScreen.remove
  u.initPlugin $("#unityPlayer")[0], filename
  return
