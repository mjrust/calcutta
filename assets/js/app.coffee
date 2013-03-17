
jQuery -> 
  refresh = ->
    window.location = "/owners"
    
  show_admin = ->
    $('.admin_buttons').show()
    
  if $.cookie "admin"
    show_admin()
    
  socket = io.connect 'http://localhost:3004'
  socket.on 'owner:changed', () ->
    refresh()
    
  $('.delete-team').on 'click', () ->
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
    
  $('.delete-owner').on 'click', () ->
    path = this.href
    div = $(this).parent().parent()
    if confirm "Are you sure?"
      console.log path
      $.ajax
        url: path
        method: "DELETE"
        success: () ->
        div.fadeOut(500)
          
    return false
    
    
    
