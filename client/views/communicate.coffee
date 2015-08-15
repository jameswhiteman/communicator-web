root = global ? window

if root.Meteor.isClient
    message = sender: '29873h3h9837h'
    message.videos = []
    message.images = []
    message.audios = []
    message.texts = []
    message.locations = []
    Template.communicate.events
        'click .close-modal-input-text' : (e) ->
            $('#modal-input-text').closeModal()
        'click .add-modal-input-text' : (e) ->
            $('#modal-input-text').closeModal()
            text = $('#input-text').val()
            message.texts.push text
        'click #location' : (e) ->
            console.log 'getting location'
            location = Geolocation.latLng()
            message.locations.push location
        'click #send' : (e) ->
            message.timestamp = new Date().getTime()
            Messages.insert message
            message.videos = []
            message.images = []
            message.audios = []
            message.texts = []
            message.locations = []

        'click #image' : (e) ->
            dataUri = MeteorCamera.getPicture {
                quality: 80
            }, (error, data) ->
                if error
                    alert 'error'
                else
                    console.log data
                    message.images.push data
