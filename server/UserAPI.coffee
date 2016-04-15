Meteor.startup ->
  User = new Restivus
#    version: 'v1'
    apiPath: 'user'
    useDefaultAuth: true
    auth:
      token: 'services.resume.loginTokens.hashedToken'
      user: ->
        userId: this.request.headers['x-user-id'],
        token: Accounts._hashLoginToken(this.request.headers['x-auth-token'])
    defaultHeaders:
      'Content-Type': 'text/json'
      'X-Test-Header': 'test header'
    defaultOptionsEndpoint: ->
      headers:
        'Content-Type': 'text/plain'
      body: 'options'

  User.addCollection(Meteor.users);

  User.addRoute 'articles/:id', authRequired: true,
    post: ->
      Articles.findOne @urlParams.id
    delete:
      roleRequired: ['author', 'admin']
      action: ->
        if Articles.remove @urlParams.id
          status: 'success', data:
            message: 'Article removed'
        else
          statusCode: 404
          body:
            status: 'fail', message: 'Article not found'