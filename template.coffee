exports.description = 'Scaffold a node/browser commonjs project'


exports.notes =
  """
  Generates a node/browser commonjs project with basic travis/testling configuration
  """


exports.after =
  """
  Project ready, install the dependencies with 'npm install'
  """


exports.warnOn = '*'


isBoolean = (answer) ->
  answer == 'Y/n' or /^y$/i.test(answer) or answer == 'y/N' or
  /^n$/i.test(answer)


toBoolean = (answer) -> answer == 'Y/n' or /^y$/i.test(answer)


jshintDefaults =
  es3: true
  curly: false
  eqeqeq: true
  immed: true
  latedef: true
  newcap: true
  noarg: true
  sub: true
  undef: true
  boss: true
  eqnull: true
  node: true
  browser: true
  debug: true


jshintTestDefaults =
  globals: expect: false, run: false
  expr: true


exports.template = (grunt, init, done) ->
  init.process({}, [
    init.prompt('name')
    init.prompt('description')
    init.prompt('version', '0.0.0')
    init.prompt('repository')
    init.prompt('homepage')
    init.prompt('bugs')
    init.prompt('licenses', 'MIT')
    init.prompt('author_name')
    init.prompt('author_email')
    init.prompt('author_url')
    {
      name: 'isPrivate'
      message: 'Is this a private project?'
      default: 'y/N'
      warning: 'Answer y/n'
      validator: isBoolean
      sanitize: (value, data, done) ->
        data.isPrivate = toBoolean(value)
        done()
    }
  ], (err, props) ->

    props.username = process.env['USER']
    files = init.filesToCopy(props)
    init.addLicenseFiles(files, props.licenses)
    init.copyAndProcess(files, props)

    grunt.file.write('.jshintrc', JSON.stringify(jshintDefaults, null, 2))
    grunt.file.write('test/.jshintrc',
      JSON.stringify(jshintTestDefaults, null, 2))

    init.writePackageJSON('package.json', props, (pkg) =>
      pkg.main = './index'

      if props.isPrivate
        pkg.private = true

      pkg.devDependencies =
        'mocha': '~1.16.2'
        'nodemon': '1.0.7'
        'testling': '~1.5.6',
        'browserify': '~3.19.0'

      pkg.scripts = test: 'make test'

      pkg.testling =
        browsers: [
          ie: [ 6, 7, 8, 9 ]
          ff: [ 3.5, 10, 15 ]
          chrome: [ 10, 22 ]
          safari: [ 5.1 ]
          opera: [ 12 ]
        ]
        harness: 'mocha'
        files: 'test/*.js'

      return pkg
    ))
