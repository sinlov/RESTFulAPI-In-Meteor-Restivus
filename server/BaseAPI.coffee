Items = new Mongo.Collection 'items'
Articles = new Mongo.Collection 'articles'

# Restivus is only available on the server!

# Global API configuration
BaseApi = new Restivus
  prettyJson: true
  useDefaultAuth: true
#  auth:
#    token: 'services.resume.loginTokens.hashedToken'
#    user: ->
#      userId: @request.headers['s_user_id']
#      token: Accounts._hashLoginToken @request.headers['s_auth_token']

# Generates: GET, POST on /api/items and GET, PUT, DELETE on
# /api/items/:id for the Items collection
BaseApi.addCollection Items

# Generates: POST on /api/users and GET, DELETE /api/users/:id for
# Meteor.users collection
#Api.addCollection Meteor.users,
#  excludedEndpoints: ['getAll', 'put']
#  routeOptions:
#    authRequired: true
#  endpoints:
#    post:
#      authRequired: false
#    delete:
#      roleRequired: 'admin'

# Maps to: /api/articles/:id
#Api.addRoute 'articles/:id', authRequired: true,
#  post: ->
#    Articles.findOne @urlParams.id
#  delete:
#    roleRequired: ['author', 'admin']
#    action: ->
#      if Articles.remove @urlParams.id
#        status: 'success', data:
#          message: 'Article removed'
#      else
#        statusCode: 404
#        body:
#          status: 'fail', message: 'Article not found'