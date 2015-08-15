root = global ? window

if root.Meteor.isClient
    # Routes
    Router.configure
        onAfterAction: ->
            @render 'site'
            @render 'navigation', {to: 'header'}
            @render 'about', {to: 'footer'}
    Router.route '/', ->
        @render 'communicate', {to: 'content'}
    Router.route '/communicate', ->
        @render 'communicate', {to: 'content'}

    Template.site.rendered = ->
        $('.controls').pushpin top: 1500

    Template.communicate.rendered = ->
        $('.modal-trigger').leanModal()
