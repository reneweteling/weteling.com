#= require jquery3
#= require jquery-migrate
#= require jquery_ujs
#= require turbolinks
#= require popper
#= require bootstrap
#= require stellar
#= require waypoints

jQuery.migrateMute = true

$ ->
  # Waypoints
  new Waypoint
    element: $('#home h1')[0],
    handler: (direction) -> 
      section = $('#home')
      $('.section').not(section).removeClass 'active'
      $(section).addClass 'active' 
      console.log("Scrolled to section #{ $(section).attr('id') }")

      
  $('.section').each (i, section) ->
    new Waypoint
      element: section,
      handler: (direction) -> 
        $('.section').not(section).removeClass 'active'
        $(section).addClass 'active' 
        console.log("Scrolled to section #{ $(section).attr('id') }")
          