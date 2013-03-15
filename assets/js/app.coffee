


jQuery -> 
  refresh = ->
    window.location = "/owners"
    
  socket = io.connect 'http://localhost:3004'
  socket.on 'owner:changed', () ->
    console.log "owner changed"
    refresh()
    
  
  
  $('.btn-danger').on 'click', () ->
    path = this.href
    row = $(this).closest("tr").get(0);
    if confirm "Are you sure?"
      console.log path
      $.ajax
        url: path
        method: "DELETE"
        success: () ->
          $(row).fadeOut(500)
    
    return false
    
  $('.toggle-teams').on "click", () ->
    console.log $(this).parent().siblings('div.owner-teams')
    $(this).parent().siblings('div.owner-teams').modal()
    
    
