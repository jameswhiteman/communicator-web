root = global ? window

if root.Meteor.isClient

    Template.connect.helpers
        users: ->
            Meteor.users.find({})
