template = require './home'
Naughts = require './naughts/naughts'

HomeView = Backbone.View.extend
    initialize: ->
        @naughts = new Naughts

        @naughts.on 'move', _.bind(@move, @)
        @naughts.on 'finish', _.bind(@finish, @)
        @naughts.on 'invalid', _.bind(@invalid, @)

    template: template

    events:
        "click .board li": "cell_clicked"

    move: (index, side) ->
        $cell = $('.board li:eq(' + index + ')')

        if side is 'naughts'
            @show_caption()
        
        @set_cell side, $cell

    invalid: (index, side) ->
        $('.captions h2').hide();  
        $('.captions h2#invalid').fadeIn('slow'); 

    finish: (result) ->
        $('.captions h2').hide();  
        $('.captions h2#' + result).fadeIn('slow');   

    show_caption: ->
        captions_length = $(".captions h2.muted").length
        caption = Math.floor(Math.random() * captions_length)

        if caption is $('.captions h2:visible').index()
            show_caption()
            return

        $('.captions h2').hide();
        $(".captions h2.muted:eq(#{caption})").fadeIn('slow');

    cell_clicked: (event) ->
        if event.target.nodeName isnt 'SPAN'
            @naughts.move $(event.target).index()

    set_cell: (side, element) ->
        sides =
            naughts: '<span>◯</span>',
            crosses: '<span>✕</span>'

        element.addClass side
        element.html sides[side]

    render: ->
        @$el.html @template()
        @

module.exports = HomeView