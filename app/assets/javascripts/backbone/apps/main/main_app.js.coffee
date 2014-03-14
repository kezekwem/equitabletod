@Equitabletod.module "MainApp", (MainApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false
      
  class MainApp.Router extends Marionette.AppRouter
    appRoutes:
      "home": "showHomeRegion"
      "usrguid/": "showUsrGuid"
      "map": "provideMap"
      "search/submit": "searchSubmit"
#      "map/": "provideMap"
  
  
  API =
    showHomeRegion: ->
      MainApp.Show.Controller.showHomeRegion()

    showCarousel: ->
      MainApp.Carousel.Controller.showCarousel()

    showSimpleSearchForm: ->
      MainApp.Search.Controller.showSimpleSearchForm()

#    provideMap: ->
#      MainApp.Map.Controller.addMap()

    showResultsPage: ->
      MainApp.Results.Controller.showResultsView()


#    removeHomeRegion: =>
#      @RegionMan.reset()

    

    
#    showSearchModule: ->
#      MainApp.Search.Controller.showSearchModule()
#    provideMap: ->
#      MainApp.Map.Controller.provideMap()
  MainApp.on "initialize:before", ->
    searchargs = App.request 'fstation:entities'
  MainApp.on "start", ->
    API.showHomeRegion()
#    API.showSearchModule()
    API.showSimpleSearchForm()   
#    API.showCarousel()
#    API.showResultsPage()
#    API.provideMap()
<<<<<<< HEAD
#    API.showHomeRegion()
    API.showSimpleSearchForm()
=======
#   API.showUsrGuid()

>>>>>>> design
