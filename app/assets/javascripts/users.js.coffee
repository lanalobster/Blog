$(".generate-button").on "click", ->
  $.ajax {
    url: '/generate_username'
    type: 'post'
    dataType: 'script'
    success: () ->
  }