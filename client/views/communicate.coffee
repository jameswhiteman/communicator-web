root = global ? window

if root.Meteor.isClient
    message = sender: '29873h3h9837h', communications: []
    communication = type: 'text', value: ''
    audioRecording = false
    microphone = null
    node = null
    playing = false
    audioClip = []

    Meteor.methods
        'save-audio': (audioData) ->

    Template.communicate.helpers
        messages: ->
            Messages.find({})
        isEqual: (string, value) ->
            string == value
        getMap: (location) ->
            if location
                coordinates = location.lat + "," + location.lng
                zoomLevel = 15
                width = 280
                height = 280
                return "https://maps.googleapis.com/maps/api/staticmap?center=" + coordinates + "&zoom=" + zoomLevel + "&markers=" + coordinates + "&size=" + width + "x" + height
            else
                return "http://cdn.designsrazzi.com/wp-content/uploads/2013/09/earth.jpg"
    Template.communicate.events
        'click .close-modal-input-text' : (e) ->
            $('#modal-input-text').closeModal()
        'click .add-modal-input-text' : (e) ->
            $('#modal-input-text').closeModal()
            text = $('#input-text').val()
            communication.type = 'text'
            communication.value = text
            final = jQuery.extend true, {}, communication
            message.communications.push final
            $('#input-text').val ''
        'click #location' : (e) ->
            console.log 'getting location'
            location = Geolocation.latLng()
            communication.type = 'location'
            communication.value = location
            final = jQuery.extend true, {}, communication
            message.communications.push final
        'click #send' : (e) ->
            message.timestamp = new Date().getTime()
            final = jQuery.extend true, {}, message
            Messages.insert final
            message.type = 'text'
            message.communications = []

        'click #playAudio': (e) ->
            sound = $('#playAudio').attr 'name'
            if node
                if playing
                    node.stop()
                    playing = false
                    $('#playAudioIcon').html("stop")
                    return
            lastSound = sound
            audioContext = new (window.AudioContext || window.webkitAudioContext)()
            audioBuffer = audioContext.createBuffer 1, sound.length, audioContext.sampleRate
            audioBuffer.getChannelData(0).set(Float64Array.from(sound))
            node = audioContext.createBufferSource()
            node.buffer = audioBuffer
            node.connect audioContext.destination
            node.start(0)
            playing = true
            $('#playAudioIcon').html("play")
        'click #image' : (e) ->
            dataUri = MeteorCamera.getPicture {
                quality: 80
            }, (error, data) ->
                if error
                    console.error JSON.stringify(error)
                else
                    communication.type = 'image'
                    communication.value = data
                    final = jQuery.extend true, {}, communication
                    message.communications.push final
        'click #audio' : (e) ->
            # Stop recording if already recording
            if audioRecording
                audioRecording = false
                if microphone
                    communication.type = 'audio'
                    communication.value = audioClip
                    final = jQuery.extend true, {}, communication
                    message.communications.push final
                    audioClip = []
                    microphone.stop()
                    microphone.onAudioData = null
                    microphone = null
                return
            audioRecording = true

            # Initialize microphone first time
            audioContext = new AudioContext
            webAudioNode = audioContext.createGain()
            microphone = new Microphone(
                audioContext: audioContext
                onSuccess: ->
                    microphone.connect myWebAudioNode
                    webAudioNode.connect audioContext.destination
                    return
                onReject: ->
                    console.error 'Mic access rejected'
                    return
                onNoSignal: ->
                    console.error 'No signal received so far, check your systems settings!'
                    return
                onNoSource: ->
                    console.error 'No getUserMedia and no Flash available in this browser!'
                    return
                onAudioData: (audioData) ->
                    data = $.map(audioData, (el) ->
                        el
                    )
                    console.log JSON.stringify(data)
                    audioClip.push data
                    return
            )
