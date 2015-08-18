# Routes
Router.configure
    onAfterAction: ->
        @render 'site'
        @render 'navigation', {to: 'header'}
        @render 'about', {to: 'footer'}
        @render 'unverified', {to: 'unverified'}
Router.route '/', ->
    @render 'communicate', {to: 'content'}
Router.route '/communicate', ->
    @render 'communicate', {to: 'content'}
, fastRender:true, waitOn: ->
    Meteor.subscribe 'messages'
Router.route '/profile', ->
    @render 'profile', {to: 'content'}
Router.route '/connect', ->
    @render 'connect', {to: 'content'}
