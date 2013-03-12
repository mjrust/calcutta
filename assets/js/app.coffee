
jQuery ->
  $('.btn-danger').on 'click', (e) ->
    path = this.href
    row = $(this).closest("tr").get(0);
    if confirm "Are you sure?"
      console.log path
      $.ajax
        url: path
        method: "DELETE"
        success: () ->
          $(row).fadeOut(500)
          # location.reload()
    
    return false