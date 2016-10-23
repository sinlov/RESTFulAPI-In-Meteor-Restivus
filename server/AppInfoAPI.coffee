AppInfo = new Mongo.Collection 'AppInfo'


Meteor.startup ->
  AppInfoAPI = new Restivus
    apiPath: 'app'
    useDefaultAuth: true
    prettyJson: true
    defaultHeaders:
      'Content-Type': 'text/json'
    defaultOptionsEndpoint: ->
      headers:
        'Content-Type': 'text/plain'
      body: 'options'

  AppInfoAPI.addCollection(AppInfo)

  AppInfoAPI.addRoute 'addAppInfo', authRequired: false,
    post: ->
      head = @bodyParams
      data = @bodyParams
      console.log(head)
      console.log(data)
      console.log(_.isEmpty(data))
      if _.isEmpty(data)
        messageOut = 'appInfo is null'
      roleRequired: ['message', 'admin']
#      if _.isEmpty(data)
      action: ->
        if _.isEmpty(data)
          statusCode: 404
          body:
            status: 'fail',
            message: 'appInfo is null'
        else
          AppInfo.insert(data)
          status: 'success',
          data:
            message: 'add app info success'


  AppInfoAPI.addRoute 'appInfo/:id', authRequired: false,

    get: ->
      authRequired: false
      appInfo = AppInfo.findOne @urlParams.id
      if appInfo
        status: 'success',
        data:
          appInfo: appInfo
          message: 'find one app info'
      else
        statusCode: 404
        body:
          status: 'fail',
          message: 'appInfo not found'
    delete:
      authRequired: false
      action: ->
        if AppInfo.remove @urlParams.id
          status: 'success', data:
            message: 'Article removed'
        else
          statusCode: 404
          body:
            status: 'fail', message: 'appInfo not found'