@Equitabletod.module "FstationsApp.List", (List, App, Backbone, Marionette, $, _) ->

	List.Controller =

		getFstationById: (q) ->
			# getting the current data for today to be later put on the pdf
			today = new Date()
			dd = today.getDate()
			mm = today.getMonth() + 1 #January is 0!
			yyyy = today.getFullYear()
			dd = "0" + dd  if dd < 10
			mm = "0" + mm  if mm < 10
			gon.today = mm + "/" + dd + "/" + yyyy
			#
			urlstr = "/search.json?" + "#{q}"
			responseFeature = $.ajax
		          	url: urlstr
		          	done: (result) =>
		              	return result
		    collection = responseFeature.complete()
		   	collection.done =>
				    fstations = collection.responseJSON
				    features = _.values fstations.features
				    @fstations = App.request "set:fstation", features
				    gon.features = features
				    gon.searchresults = features
				    if @fstations.length == 1
				    	gon.feature = gon.features
				    	gon.features = gon.searchresults if gon.searchresults
				    	gon.searchresults = []
				    	gon.dictionaries = []
		    			@layout = @getLayoutView() 	
		    			#fstationCollection = new Backbone.Collection gon.feature
		    			@layout.on 'show', =>
		    				@showDictView gon.dictionaries
		    				@showDetstations @fstations
		    				@showDetailMap @fstations
		    				@showChart gon.feature
		    		else
		    			gon.length = features.length
		    			gon.searchresults = features
		    			gon.fstations = @fstations
		    			@layout = @getLayoutView() 
		    			@layout.on 'show', =>
		    				@showFstations @fstations
		    				@showMap @fstations

		    		@layout.on 'close', =>
            			$(".feedback_trigger").removeClass "fm_bootstrap"
            			$(".feedback_trigger").removeClass "feedback_trigger_closed"
            			$(".feedback_trigger").html "<span></span>"
            			$(".feedback_trigger").removeClass "feedback_trigger left-top  hero-unit"
		    		
		    		App.mainRegion.show @layout 


		showDetstations: (fstations) ->
			detstationsView = @getDetstationsView fstations
			@layout.fstationsRegion.show detstationsView

		getDetstationsView: (fstations) ->
			new List.Detstations
				collection: fstations

		showFstations: (fstations) ->
			fstationsView = @getFstationsView fstations
			@layout.fstationsRegion.show fstationsView

		getFstationsView: (fstations) ->
			new List.Fstations
				collection: fstations
		
		showMap: (fstationsCollection) ->
			mapView = @getMapView fstationsCollection
			@layout.mapRegion.show mapView

		showDetailMap: (fstation) ->
			detailMapView = @getDetailMapView fstation
			@layout.mapRegion.show detailMapView

		showDictView: (dictionaries) ->
			dictView = @getDictView dictionaries
			@layout.chartRegion.show dictView

		showChart: (fstation) ->
			chartView = @getChartView fstation
			@layout.chartRegion.show chartView

		getChartView: (fstation) ->
			new List.Chart
				collection: fstation.toJSON

		getMapView: (fstationsCollection) ->
			new List.Map
				collection: fstationsCollection

		getDictView: (dictionaries) ->
			new List.DictView
				collection: dictionaries.toJSON

		getDetailMapView: (fstation) ->
			new List.MapDetail
				collection: fstation

		getLayoutView: ->
			new List.Layout