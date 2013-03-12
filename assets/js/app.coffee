
jQuery ->
  $('.btn-danger').on 'click', (e) ->
    path = $(this).attr('href')
    if confirm "Are you sure?"
      console.log path
      $.ajax
        url: path
        method: "DELETE"
        success: () ->
          location.reload()
    
    return false