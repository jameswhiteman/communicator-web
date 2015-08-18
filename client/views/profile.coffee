root = global ? window

if root.Meteor.isClient

    Template.profile.helpers
        firstName: ->
            user = Meteor.user()
            if user
                return user.profile.firstName
            return ''
        lastName: ->
            user = Meteor.user()
            if user
                return user.profile.lastName
            return ''
        picture: ->
            user = Meteor.user()
            if user
                return user.profile.picture
            return ''
        hasFirstName: ->
            user = Meteor.user()
            if user and user.profile.firstName
                return true
            return false
        hasLastName: ->
            user = Meteor.user()
            if user and user.profile.lastName
                return true
            return false
        hasPicture: ->
            user = Meteor.user()
            if user and user.profile.picture
                return true
            return false


    Template.profile.events
        'click #submit' : (e) ->
            newFirstName = $('#firstName').val()
            newLastName = $('#lastName').val()
            newPicture = $('#picture').val()
            data = Meteor.user().profile
            data.firstName = newFirstName
            data.lastName = newLastName
            data.picture = newPicture
            Meteor.users.update(Meteor.userId(), {$set: {profile: data}})
            Materialize.toast 'Profile updated', 3000
