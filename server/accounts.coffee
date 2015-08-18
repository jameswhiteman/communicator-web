Accounts.onCreateUser (options, user) ->
    user.profile =
        firstName: 'Anonymous'
        lastName: ''
    user
