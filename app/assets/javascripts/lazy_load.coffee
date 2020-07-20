initPage = ->

  for card_name, idx in ['erdnuss', 'weather', 'well_com']
    fun = (cn) ->
      $.ajax
        url: "/cards/#{cn}"
        cache: false
        success: (html, blah) ->
          $("#card_#{cn}").html html
          return
    fun(card_name)

document.addEventListener('turbolinks:load', initPage) # this set the trigger for page changes
