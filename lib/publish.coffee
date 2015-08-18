root = global ? window

if root.Meteor.isServer
    Meteor.publish 'messages', ->
        Messages.find()
