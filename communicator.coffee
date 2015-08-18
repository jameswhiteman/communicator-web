root = global ? window

if root.Meteor.isClient

    Template.navigation.rendered = ->
        $(".button-collapse").sideNav()

    Template.communicate.rendered = ->
        $('.controls').pushpin({top:0,bottom:10000,offset:20})
        $('.modal-trigger').leanModal()
