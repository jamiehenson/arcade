---
---

$ ->
  passerby = new Audio('assets/tunes/passerby64.m4a')
  hands = new Audio('assets/tunes/hands64.m4a')
  audio = ''
  codes = [
    'ainz',
    'pupper',
    'bosco',
    'mehmet',
    'cashflow'
  ]

  $(".arcade-player").click ->
    if audio != ''
      if $(".play-button").hasClass("fa-play") then audio.play() else audio.pause()
      $(".play-button").toggleClass("fa-play fa-pause")

  surfaces = ['arrows', 'carbon', 'cube', 'honeycomb', 'marrakech', 'posh', 'rhombus', 'stars', 'zigzag']

  generateColour = (manual) ->
    colour = '#'
    colour += '0123456789ABCDEF'[Math.floor(Math.random() * 16)] for i in [1..6]
    $(".arcade-header").css("background-color", colour)
    $(".arcade-drawer .drawer-button").css("background-color", colour)

    if manual || $(window).width() > 768
      $(".arcade-drawer").removeClass(surface) for surface in surfaces
      $(".arcade-drawer").addClass(surfaces[Math.floor(Math.random() * surfaces.length)])

  generalGameLoadStuff = ->
    $(".game-view").css("display", "flex")
    $(".game-menu").addClass("off")
    $(".play-button").addClass("fa fa-pause")
    $(".arcade-player").addClass("on")
    $(".game-auth-input").val("")

  generateColour()

  $(".game-icon-content").click ->
    if $(this).parent().hasClass("game-one")
      generalGameLoadStuff()
      $(".game-frame.game-one").css("display", "flex")
      $(".play-message").text("- Passerby -")
      audio = passerby
      audio.play()
    if $(this).parent().hasClass("game-two")
      $(".game-two .game-icon-content").hide()
      $(".game-auth-box").addClass("on")

  $(".game-auth-go").click ->
    if codes.indexOf($(".game-auth-input").val().toLowerCase()) != -1
      generalGameLoadStuff()
      $(".game-frame.game-two").css("display", "flex")
      $(".play-message").text("- Heart & Soul -")
      $(".game-auth-box").removeClass("on")
      $(".game-two .game-icon-content").show()
      audio = hands
      audio.play()
    else
      $(".game-auth-input").addClass("invalid")
      setTimeout ( ->
        $(".game-auth-input").removeClass("invalid")
      ), 1000

  $(".game-auth-cancel").click ->
    $(".game-auth-box").removeClass("on")
    $(".game-two .game-icon-content").show()

  $(".back").click ->
    game.state.start('menu') for game in Phaser.GAMES
    $(".game-menu").css("display", "flex")
    $(".game-frame").hide()
    $(".game-view").hide()
    $(".game-menu").removeClass("off")
    $(".screen").removeClass("off")
    $(".play-message").text("")
    $(".play-button").removeClass("fa fa-play fa-pause")
    $(".arcade-player").removeClass("on")
    audio.pause()
    audio.currentTime = 0;
    audio = ''

  $(".colour-shuffle").click ->
    generateColour(true)

  $(".about-link").click ->
    $(".about-view").removeClass("off")
    $(".game-menu").addClass("off")
    $(".game-frame").hide()
    $(".game-view").hide()

  $(".about-back").click ->
    $(".about-view").addClass("off")
    $(".game-menu").removeClass("off")
