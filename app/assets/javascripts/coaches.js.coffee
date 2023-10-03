# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#new_coach").on("ajax:success", (e, data, status, xhr) ->
    # $("#new_coach").append xhr.responseText
  ).bind "ajax:error", (e, xhr, status, error) ->
    $("#new_coach").append "<p>ERROR</p>"