path = require 'path'

module.exports = (env, callback) ->

  defaults =
    postsDir: 'articles' # directory containing blog posts
    template: 'article.jade'
    filenameTemplate: '/:year/:month/:day/:file/index.html'

  # assign defaults for any option not set in the config file
  options = env.config.blog or {}
  for key, value of defaults
    options[key] ?= defaults[key]

  class BlogpostPage extends env.plugins.MarkdownPage
    ### DRYer subclass of MarkdownPage ###

    getHtml: (base) ->
      ### return html with all relative img tag urls corrected ###
      html          = super base
      imgUrlFind    = path.dirname @getFilename()
      imgUrlReplace = path.dirname @filepath.relative
      imgUrlPattern = ///(<img[^>]src="/)(#{imgUrlFind})///g

      return html.replace(imgUrlPattern, "$1#{imgUrlReplace}")

    getTemplate: ->
      @metadata.template or options.template or super()

    getFilenameTemplate: ->
      @metadata.filenameTemplate or options.filenameTemplate or super()

  # register the post plugin
  prefix = if options.postsDir then options.postsDir + '/' else ''
  env.registerContentPlugin 'posts', prefix + '**/*.*(markdown|mkd|md)', BlogpostPage

  # done!
  callback()
