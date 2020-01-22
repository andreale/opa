initPage = ->

  for card_name, idx in ['erdnuss', 'foo', 'bar']
    fun = (cn) ->
      $.ajax
        url: "/cards/#{cn}"
        cache: false
        success: (html, blah) ->
          $("#card_#{cn}").html html
          return
    fun(card_name) # preserve reference to card_name

document.addEventListener('turbolinks:load', initPage) # this set the trigger for page changes
