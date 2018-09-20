package com.weatherstation.client;


import org.gwtopenmaps.openlayers.client.control.OverviewMap;

import java.awt.MouseInfo;
import java.lang.annotation.Native;
import java.util.ArrayList;

import org.gwtopenmaps.openlayers.client.Bounds;
import org.gwtopenmaps.openlayers.client.Icon;
import org.gwtopenmaps.openlayers.client.LonLat;
import org.gwtopenmaps.openlayers.client.Map;
import org.gwtopenmaps.openlayers.client.MapOptions;
import org.gwtopenmaps.openlayers.client.MapWidget;
import org.gwtopenmaps.openlayers.client.Marker;
import org.gwtopenmaps.openlayers.client.control.LayerSwitcher;

import org.gwtopenmaps.openlayers.client.control.MouseDefaults;
import org.gwtopenmaps.openlayers.client.control.MousePosition;
import org.gwtopenmaps.openlayers.client.control.MousePositionOptions;
import org.gwtopenmaps.openlayers.client.control.MousePositionOutput;
import org.gwtopenmaps.openlayers.client.control.MouseToolbar;
import org.gwtopenmaps.openlayers.client.control.PanZoomBar;
import org.gwtopenmaps.openlayers.client.control.Scale;
import org.gwtopenmaps.openlayers.client.control.ScaleLine;
import org.gwtopenmaps.openlayers.client.control.SelectFeature;
import org.gwtopenmaps.openlayers.client.control.WMSGetFeatureInfo;
import org.gwtopenmaps.openlayers.client.control.WMSGetFeatureInfoOptions;
import org.gwtopenmaps.openlayers.client.event.EventType;
import org.gwtopenmaps.openlayers.client.event.GetFeatureInfoListener;
import org.gwtopenmaps.openlayers.client.event.GetFeatureInfoListener.GetFeatureInfoEvent;
import org.gwtopenmaps.openlayers.client.event.MarkerBrowserEventListener;
import org.gwtopenmaps.openlayers.client.feature.VectorFeature;
import org.gwtopenmaps.openlayers.client.geometry.Point;
import org.gwtopenmaps.openlayers.client.layer.Google;
import org.gwtopenmaps.openlayers.client.layer.Layer;
import org.gwtopenmaps.openlayers.client.layer.Markers;
import org.gwtopenmaps.openlayers.client.layer.Vector;
import org.gwtopenmaps.openlayers.client.layer.VectorOptions;
import org.gwtopenmaps.openlayers.client.layer.WMS;
import org.gwtopenmaps.openlayers.client.layer.WMSParams;
import org.gwtopenmaps.openlayers.client.popup.FramedCloud;
import org.gwtopenmaps.openlayers.client.popup.Popup;
import org.gwtopenmaps.openlayers.client.strategy.ClusterStrategy;
import org.gwtopenmaps.openlayers.client.strategy.Strategy;
import org.gwtopenmaps.openlayers.client.util.Attributes;
import org.gwtopenmaps.openlayers.client.util.JObjectArray;
import org.gwtopenmaps.openlayers.client.util.JSObject;

import org.gwtopenmaps.openlayers.client.layer.GMapType;

import org.gwtopenmaps.openlayers.client.layer.GoogleOptions;
import org.gwtopenmaps.openlayers.client.Projection;
import org.gwtopenmaps.openlayers.client.Size;
import org.gwtopenmaps.openlayers.client.Style;
import org.gwtopenmaps.openlayers.client.StyleMap;
import org.gwtopenmaps.openlayers.client.layer.GoogleV3;
import org.gwtopenmaps.openlayers.client.layer.GoogleV3MapType;
import org.gwtopenmaps.openlayers.client.layer.GoogleV3Options;
import org.gwtopenmaps.openlayers.client.layer.WMSOptions;

import com.google.gwt.canvas.client.Canvas;
import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.dom.client.MouseDownEvent;
import com.google.gwt.event.dom.client.MouseDownHandler;
import com.google.gwt.http.client.Request;
import com.google.gwt.http.client.RequestBuilder;
import com.google.gwt.http.client.RequestCallback;
import com.google.gwt.http.client.RequestException;
import com.google.gwt.http.client.Response;
import com.google.gwt.user.client.Window;
import com.google.gwt.user.client.ui.DockPanel;
import com.google.gwt.user.client.ui.HTML;
import com.google.gwt.user.client.ui.RootLayoutPanel;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SimpleLayoutPanel;
import com.google.gwt.user.client.ui.VerticalPanel;
import com.google.gwt.user.client.ui.Widget;
import com.google.gwt.xml.client.DOMException;
import com.google.gwt.xml.client.Document;
import com.google.gwt.xml.client.Element;
import com.google.gwt.xml.client.Node;
import com.google.gwt.xml.client.NodeList;
import com.google.gwt.xml.client.XMLParser;
import com.googlecode.gwt.charts.client.ChartLoader;
import com.googlecode.gwt.charts.client.ChartPackage;
import com.googlecode.gwt.charts.client.ColumnType;
import com.googlecode.gwt.charts.client.DataTable;
import com.googlecode.gwt.charts.client.corechart.PieChart;

/**
 * Entry point classes define <code>onModuleLoad()</code>.
 */
public class WeatherStationSOS implements EntryPoint {
	/**
	 * The message displayed to the user when the server cannot be reached or
	 * returns an error.
	 */
	private static Vector stationsLayer;
	static String xmlResponse = "";
	static String ggl;
	static String valuee;
	static Size size;
	static String popupString;
	static String passObservation;
	static PieChart pieChart;
	static SimpleLayoutPanel layoutPanel;
	public static ArrayList<String> stationsLatLonList;
	static NodeList systems;
	NodeList children;
	private static Popup popup;
		private static final Projection DEFAULT_PROJECTION = new Projection(
			       "EPSG:4326");
		private native void publish() /*-{
	    $wnd.getCap = @com.weatherstation.client.WeatherStationSOS::getCap(Ljava/lang/String;)
	  }-*/;
		private native void publishTemp() /*-{
	    $wnd.tempMarkers = @com.weatherstation.client.WeatherStationSOS::tempMarkers(Ljava/lang/String;)
	  }-*/;
		private native void publishPrecipitation() /*-{
	    $wnd.precipitationMarkers = @com.weatherstation.client.WeatherStationSOS::precipitationMarkers(Ljava/lang/String;)
	  }-*/;
		private native static void publishValue(String msg) /*-{
	    $wnd.alert(msg)
	  }-*/;
		private native void publishPressure() /*-{
	    $wnd.pressureMarkers = @com.weatherstation.client.WeatherStationSOS::pressureMarkers(Ljava/lang/String;)
	  }-*/;
		private native static void publishObservationValue(String msg) /*-{
	    $wnd.alert(msg)
	  }-*/;
		private native static void publishPrecipitationValue(String msg) /*-{
	    $wnd.alert(msg)
	  }-*/;
		private native static void publishPressureValue(String msg) /*-{
	    $wnd.alert(msg)
	  }-*/;
		private native static void publishEvapoValue(String msg) /*-{
	    $wnd.alert(msg)
	  }-*/;
		private native void publishEvapotranspiration() /*-{
	    $wnd.evapotranspirationMarkers = @com.weatherstation.client.WeatherStationSOS::evapotranspirationMarkers(Ljava/lang/String;)
	    	  }-*/;
		private native static void publishAlert(String msg) /*-{
	    $wnd.alert(msg)
	    	  }-*/;
		private native static void publishObsTemp() /*-{
	    $wnd.getObsTemp = @com.weatherstation.client.WeatherStationSOS::getObsTemp(Ljava/lang/String;)
	    	  }-*/;
		private native static void publishObsPrecipitation() /*-{
	    $wnd.getObsPrecipitation = @com.weatherstation.client.WeatherStationSOS::getObsTemp(Ljava/lang/String;)
	    	  }-*/;
		private native static void publishObsPressure() /*-{
	    $wnd.getObsPressure = @com.weatherstation.client.WeatherStationSOS::getObsTemp(Ljava/lang/String;)
	    	  }-*/;
		private native static void publishObsEvapo() /*-{
	    $wnd.getObsEvapo = @com.weatherstation.client.WeatherStationSOS::getObsTemp(Ljava/lang/String;)
	    	  }-*/;
		private native static void publishVal() /*-{
	    $wnd.getObsBoolean = @com.weatherstation.client.WeatherStationSOS::getObsBoolean(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)
	    	  }-*/;
				private MapWidget mapWidget;
				private static Map map;
				private WMS wmsLayer,wmsLayer2,wmsLayer3;
				private GMapType gType;
				private String ss;
				private native void publishMap() /*-{
			    $wnd.getFeatures = @com.weatherstation.client.WeatherStationSOS::getFeatures(Ljava/lang/String;)
			    	  }-*/;
				private native void publishSens() /*-{
			    $wnd.describeSensors = @com.weatherstation.client.WeatherStationSOS::describeSensors(Ljava/lang/String;)
			    	  }-*/;
				/**
				 * This is the entry point method.
				 */
				public void onModuleLoad() {
					publish();
					publishTemp();
					publishEvapotranspiration();
					publishPrecipitation();
					publishPressure();
					publishMap();
					publishObsTemp();
					publishObsEvapo();
					publishObsPrecipitation();
					publishObsPressure();
					publishVal();
					publishSens();
					MapOptions mapOptions = new MapOptions();
					mapOptions.setControls(new JObjectArray(new JSObject[] {}));
					mapOptions.setNumZoomLevels(10);
					mapOptions.setProjection("EPSG:4326");
					
					// letÕs create map widget and map objects
					mapWidget = new MapWidget("1050px", "650px", mapOptions);
					map = mapWidget.getMap();

					        GoogleV3Options gNormalOptions = new GoogleV3Options();
					        gNormalOptions.setIsBaseLayer(true);
					        gNormalOptions.setType(GoogleV3MapType.G_NORMAL_MAP);
					        GoogleV3 gNormal = new GoogleV3("Google Normal", gNormalOptions);
					      	
					        map.addLayer(gNormal);
					        gNormal.setIsVisible(true);
					       // LonLat lonLat = new LonLat(82.5, 22.5);
					        LonLat lonLat = new LonLat(77.219673, 26.63281);
					        lonLat.transform(DEFAULT_PROJECTION.getProjectionCode(),map.getProjection()); 
					       map.setCenter(lonLat, 5);
			        map.addControl(new LayerSwitcher()); 
			        map.addControl(new OverviewMap()); 
			        map.addControl(new ScaleLine()); 
			        map.addControl(new MouseDefaults());
					map.addControl(new PanZoomBar());
					 MousePositionOutput mpOut = new MousePositionOutput() {
						 @Override
						 public String format(LonLat lonLat, Map map) {
						 String out = "";
						 out += "<b>Longitude: </b> ";
						 out += lonLat.lon();
						 out += "<b>Latitude</b> ";
						 out += lonLat.lat();
						 return out;
						 }
						 };
						 MousePositionOptions mpOptions = new MousePositionOptions();
						 mpOptions.setFormatOutput(mpOut); // rename to setFormatOutput
						 map.addControl(new MousePosition(mpOptions));
						 map.addControl(new LayerSwitcher());
						 map.addControl(new OverviewMap());
						 map.addControl(new ScaleLine());
						//map.setCenter(new LonLat(-98, 40));
					// 3 layers example
					//map.addLayers(new Layer[] {googlemap1,wmsLayer2,wmsLayer3});
					
					// map.addControl(new OverviewMap());
					
					 //Center for 2 layers example
					//LonLat center = new LonLat(-100.99, 40.73);
					DockPanel dockPanel = new DockPanel();
					dockPanel.setHorizontalAlignment(DockPanel.ALIGN_RIGHT);
					dockPanel.add(mapWidget, DockPanel.EAST);
					dockPanel.setBorderWidth(0);
					RootPanel.get().add(dockPanel);
				}
					public static void getCap(String url)
					{
					RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
				try {
			      builder.sendRequest(null,new RequestCallback() {

			        public void onError(Request request, Throwable exception) {
			        	
			        }
					public void onResponseReceived(Request request, Response response) {
			            System.out.println(response.getStatusCode());
			            System.out.println("Hi");
						if (200 == response.getStatusCode()) {
							xmlResponse = response.getText();
							publishAlert(xmlResponse);
			            }
					}
				});
				}
				catch(Exception e)
			      {
			    	  System.out.println(e);
			      }
					}
					public static void tempMarkers(String url)
					{
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						builder.setTimeoutMillis(15000);

						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     
						                     String latt[] = new String[100];
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("coordinates").item(0).getFirstChild().getNodeValue());
						                            System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt[i] = stationsLatLonList.get(i);
						                            
						                        }
						                     }
						                     ClusterStrategy clusterStrategy = new ClusterStrategy();
						                     clusterStrategy.setDistance(20);
						                     clusterStrategy.setThreshold(2);
						                     VectorOptions vectorOptions = new VectorOptions();
						                     vectorOptions.setStrategies(new Strategy[]{clusterStrategy});
						                     stationsLayer = new Vector("Stations",vectorOptions);
						                     VectorFeature[] point_features = new VectorFeature[latt.length];
						                     Style st=new Style();
						                     st.setGraphicSize(7, 14);
						                     st.setExternalGraphic("http://www.clker.com/cliparts/R/K/r/C/f/o/red-marker-black-border-md.png");
						                     st.setFillOpacity(0.8);
						                     Markers layer = new Markers("TemperatureSensors");
						                     StyleMap stMap=new StyleMap(st);
						                     stationsLayer.setStyleMap(stMap);
						                     for(int i=0;i<systems.getLength();i++) {
						                         System.out.println(latt[i]);
						                         String []latlon=latt[i].split(",");
						                         LonLat lonLat = new LonLat(Double.parseDouble(latlon[0]),Double.parseDouble(latlon[1]));
						                         lonLat.transform(DEFAULT_PROJECTION.getProjectionCode(),map.getProjection()); 
						                         
						                         //Point p=new Point(lonLat.lon(),lonLat.lat());
						                         //lonlat.transform(DEFAULT_PROJECTION.getProjectionCode(), map.getProjection());
						                         //point_features[i]=new VectorFeature(p);
						                         
						                         //Attributes atd=new Attributes();
						                         //atd.setAttribute("name",stationNamesList.get(i)+"\n"+stationsLatLonList.get(i));
						                         //point_features[i].setAttributes(atd);
						                         //map.addLayer(layer);
							                     Icon icon = new Icon("http://www.clker.com/cliparts/R/K/r/C/f/o/red-marker-black-border-md.png",
							                             new Size(16, 16));
							                     final Marker marker = new Marker(lonLat, icon);
							                     layer.addMarker(marker);
						                         //stationsLayer.addFeature(point_features[i]);
							                     size = new Size(10.0f, 10.0f);
							                     popupString = "Latitude: "+latlon[0]+" Longitude: "+latlon[1];
							                     marker.addBrowserEventListener(EventType.MOUSE_OVER, new MarkerBrowserEventListener() {

							                         public void onBrowserEvent(MarkerBrowserEventListener.MarkerBrowserEvent markerBrowserEvent) {
							                             popup = new FramedCloud("id1", marker.getLonLat(), null, "<h1>TemperatureSensor</H1><BR/>"+popupString, null, false);
							                             popup.setPanMapIfOutOfView(true); //this set the popup in a strategic way, and pans the map if needed.
							                             popup.setAutoSize(true);
							                             //popup.setSize(size);
							                             map.addPopup(popup);
							                         }

							                     });

							                     marker.addBrowserEventListener(EventType.MOUSE_OUT, new MarkerBrowserEventListener() {

							                         public void onBrowserEvent(MarkerBrowserEventListener.MarkerBrowserEvent markerBrowserEvent) {
							                             if(popup != null) {
							                                 map.removePopup(popup);
							                                 popup.destroy();
							                             }
							                         }

							                     });
						                     }
						                     //clusterStrategy.setFeatures(point_features);
						                     map.addLayer(layer);
						                     
						                     SelectFeature selectFeature = new SelectFeature(stationsLayer);
						                     selectFeature.setAutoActivate(true);
						                     map.addControl(selectFeature);
							            } else {
							              // Handle the error.  Can get the status text from response.getStatusText()
							            	//resp.setText("Error occured"+response.getStatusCode());
							            }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void precipitationMarkers(String url)
					{
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						builder.setTimeoutMillis(15000);

						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                    // System.out.println(xmlstr);
							            	 
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     
						                     String latt[] = new String[100];
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("coordinates").item(0).getFirstChild().getNodeValue());
						                            System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt[i] = stationsLatLonList.get(i);
						                            
						                        }
						                     }
						                     ClusterStrategy clusterStrategy = new ClusterStrategy();
						                     clusterStrategy.setDistance(20);
						                     clusterStrategy.setThreshold(2);
						                     VectorOptions vectorOptions = new VectorOptions();
						                     vectorOptions.setStrategies(new Strategy[]{clusterStrategy});
						                     stationsLayer = new Vector("Stations",vectorOptions);
						                     VectorFeature[] point_features = new VectorFeature[latt.length];
						                     Style st=new Style();
						                     st.setGraphicSize(7, 14);
						                     st.setExternalGraphic("http://www.clker.com/cliparts/5/u/N/m/7/a/marker2-md.png");
						                     st.setFillOpacity(0.8);
						                     Markers layer = new Markers("PrecipitationSensors");
						                     StyleMap stMap=new StyleMap(st);
						                     stationsLayer.setStyleMap(stMap);
						                     for(int i=0;i<systems.getLength();i++) {
						                         System.out.println(latt[i]);
						                         String []latlon=latt[i].split(",");
						                         LonLat lonLat = new LonLat(Double.parseDouble(latlon[0]),Double.parseDouble(latlon[1]));
						                         lonLat.transform(DEFAULT_PROJECTION.getProjectionCode(),map.getProjection()); 
						                         
						                         //Point p=new Point(lonLat.lon(),lonLat.lat());
						                         //lonlat.transform(DEFAULT_PROJECTION.getProjectionCode(), map.getProjection());
						                         //point_features[i]=new VectorFeature(p);
						                         
						                         //Attributes atd=new Attributes();
						                         //atd.setAttribute("name",stationNamesList.get(i)+"\n"+stationsLatLonList.get(i));
						                         //point_features[i].setAttributes(atd);
						                         //map.addLayer(layer);
							                     Icon icon = new Icon("http://www.clker.com/cliparts/5/u/N/m/7/a/marker2-md.png",
							                             new Size(16, 16));
							                     final Marker marker = new Marker(lonLat, icon);
							                     layer.addMarker(marker);
						                         //stationsLayer.addFeature(point_features[i]);
							                     popupString = "Latitude: "+latlon[0]+" Longitude: "+latlon[1];
							                     marker.addBrowserEventListener(EventType.MOUSE_OVER, new MarkerBrowserEventListener() {

							                         public void onBrowserEvent(MarkerBrowserEventListener.MarkerBrowserEvent markerBrowserEvent) {
							                             popup = new FramedCloud("id1", marker.getLonLat(), null, "<h1>PrecipitationSensor</H1><BR/>"+popupString, null, false);
							                             popup.setPanMapIfOutOfView(true); //this set the popup in a strategic way, and pans the map if needed.
							                             popup.setAutoSize(true);
							                             //popup.setSize(size);
							                             map.addPopup(popup);
							                         }

							                     });

							                     marker.addBrowserEventListener(EventType.MOUSE_OUT, new MarkerBrowserEventListener() {

							                         public void onBrowserEvent(MarkerBrowserEventListener.MarkerBrowserEvent markerBrowserEvent) {
							                             if(popup != null) {
							                                 map.removePopup(popup);
							                                 popup.destroy();
							                             }
							                         }

							                     });
						                     }
						                     //clusterStrategy.setFeatures(point_features);
						                     map.addLayer(layer);
						                     SelectFeature selectFeature = new SelectFeature(stationsLayer);
						                     selectFeature.setAutoActivate(true);
						                     map.addControl(selectFeature);
							            	  
							            } else {
							              // Handle the error.  Can get the status text from response.getStatusText()
							            	//resp.setText("Error occured"+response.getStatusCode());
							            }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void pressureMarkers(String url)
					{
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						builder.setTimeoutMillis(15000);

						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                    
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     
						                     String latt[] = new String[100];
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("coordinates").item(0).getFirstChild().getNodeValue());
						                            System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt[i] = stationsLatLonList.get(i);
						                            /*NodeList obsProp = ((Element)systems.item(i)).getElementsByTagName("observableProperty");
						                            for (int x= 0; x<obsProp.getLength();x++){
						                            	//observedPropertyListBox.addItem(((Element)obsProp.item(x)).getFirstChild().getNodeValue());
						                            }*/
						                        }
						                     }
						                     ClusterStrategy clusterStrategy = new ClusterStrategy();
						                     clusterStrategy.setDistance(20);
						                     clusterStrategy.setThreshold(2);
						                     VectorOptions vectorOptions = new VectorOptions();
						                     vectorOptions.setStrategies(new Strategy[]{clusterStrategy});
						                     stationsLayer = new Vector("Stations",vectorOptions);
						                     VectorFeature[] point_features = new VectorFeature[latt.length];
						                     Style st=new Style();
						                     st.setGraphicSize(7, 14);
						                     st.setExternalGraphic("http://www.clker.com/cliparts/8/E/b/A/6/2/orange-pin-md.png");
						                     st.setFillOpacity(0.8);
						                     Markers layer = new Markers("PressureSensors");
						                     StyleMap stMap=new StyleMap(st);
						                     stationsLayer.setStyleMap(stMap);
						                     for(int i=0;i<systems.getLength();i++) {
						                         System.out.println(latt[i]);
						                         String []latlon=latt[i].split(",");
						                         LonLat lonLat = new LonLat(Double.parseDouble(latlon[0]),Double.parseDouble(latlon[1]));
						                         lonLat.transform(DEFAULT_PROJECTION.getProjectionCode(),map.getProjection()); 
						                         
						                         //Point p=new Point(lonLat.lon(),lonLat.lat());
						                         //lonlat.transform(DEFAULT_PROJECTION.getProjectionCode(), map.getProjection());
						                         //point_features[i]=new VectorFeature(p);
						                         
						                         //Attributes atd=new Attributes();
						                         //atd.setAttribute("name",stationNamesList.get(i)+"\n"+stationsLatLonList.get(i));
						                         //point_features[i].setAttributes(atd);
						                         //map.addLayer(layer);
							                     Icon icon = new Icon("http://www.clker.com/cliparts/8/E/b/A/6/2/orange-pin-md.png",
							                             new Size(16, 16));
							                     final Marker marker = new Marker(lonLat, icon);
							                     layer.addMarker(marker);
						                         //stationsLayer.addFeature(point_features[i]);
							                     popupString = "Latitude: "+latlon[0]+" Longitude: "+latlon[1];
							                     marker.addBrowserEventListener(EventType.MOUSE_OVER, new MarkerBrowserEventListener() {

							                         public void onBrowserEvent(MarkerBrowserEventListener.MarkerBrowserEvent markerBrowserEvent) {
							                             popup = new FramedCloud("id1", marker.getLonLat(), null, "<h1>PressureSensor</H1><BR/>"+popupString, null, false);
							                             popup.setPanMapIfOutOfView(true); //this set the popup in a strategic way, and pans the map if needed.
							                             popup.setAutoSize(true);
							                             //popup.setSize(size);
							                             map.addPopup(popup);
							                         }

							                     });
							                     marker.addBrowserEventListener(EventType.MOUSE_OUT, new MarkerBrowserEventListener() {

							                         public void onBrowserEvent(MarkerBrowserEventListener.MarkerBrowserEvent markerBrowserEvent) {
							                             if(popup != null) {
							                                 map.removePopup(popup);
							                                 popup.destroy();
							                             }
							                         }

							                     });
						                     }
						                     //clusterStrategy.setFeatures(point_features);
						                     map.addLayer(layer);
						                     SelectFeature selectFeature = new SelectFeature(stationsLayer);
						                     selectFeature.setAutoActivate(true);
						                     map.addControl(selectFeature);
							            	  
							            } else {
							              // Handle the error.  Can get the status text from response.getStatusText()
							            	//resp.setText("Error occured"+response.getStatusCode());
							            }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void evapotranspirationMarkers(String url)
					{
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						builder.setTimeoutMillis(15000);

						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                    // System.out.println(xmlstr);
							            	 
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     /*
						                     final NodeList operations=messageDom.getElementsByTagName("Operation");
						                     if(operations.item(0).hasChildNodes())
						                     {
						                        }*/
						                     String latt[] = new String[100];
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("coordinates").item(0).getFirstChild().getNodeValue());
						                            System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt[i] = stationsLatLonList.get(i);
						                            
						                        }
						                     }
						                     ClusterStrategy clusterStrategy = new ClusterStrategy();
						                     clusterStrategy.setDistance(20);
						                     clusterStrategy.setThreshold(2);
						                     VectorOptions vectorOptions = new VectorOptions();
						                     vectorOptions.setStrategies(new Strategy[]{clusterStrategy});
						                     stationsLayer = new Vector("Stations",vectorOptions);
						                     VectorFeature[] point_features = new VectorFeature[latt.length];
						                     Style st=new Style();
						                     st.setGraphicSize(7, 14);
						                     st.setExternalGraphic("http://www.clker.com/cliparts/q/y/S/n/A/V/green-pin-md.png");
						                     st.setFillOpacity(0.8);
						                     Markers layer = new Markers("EvapotranspirationSensors");
						                     StyleMap stMap=new StyleMap(st);
						                     stationsLayer.setStyleMap(stMap);
						                     for(int i=0;i<systems.getLength();i++) {
						                         System.out.println(latt[i]);
						                         String []latlon=latt[i].split(",");
						                         LonLat lonLat = new LonLat(Double.parseDouble(latlon[0]),Double.parseDouble(latlon[1]));
						                         lonLat.transform(DEFAULT_PROJECTION.getProjectionCode(),map.getProjection()); 
						                         
						                         //Point p=new Point(lonLat.lon(),lonLat.lat());
						                         //lonlat.transform(DEFAULT_PROJECTION.getProjectionCode(), map.getProjection());
						                         //point_features[i]=new VectorFeature(p);
						                         
						                         //Attributes atd=new Attributes();
						                         //atd.setAttribute("name",stationNamesList.get(i)+"\n"+stationsLatLonList.get(i));
						                         //point_features[i].setAttributes(atd);
						                         //map.addLayer(layer);
							                     Icon icon = new Icon("http://www.clker.com/cliparts/q/y/S/n/A/V/green-pin-md.png",
							                             new Size(16, 16));
							                     final Marker marker = new Marker(lonLat, icon);
							                     layer.addMarker(marker);
						                         //stationsLayer.addFeature(point_features[i]);
							                     popupString = "Latitude: "+latlon[0]+" Longitude: "+latlon[1];
							                     marker.addBrowserEventListener(EventType.MOUSE_OVER, new MarkerBrowserEventListener() {

							                         public void onBrowserEvent(MarkerBrowserEventListener.MarkerBrowserEvent markerBrowserEvent) {
							                             popup = new FramedCloud("id1", marker.getLonLat(), null, "<h1>EvapotranspirationSensor</H1><BR/>"+popupString, null, false);
							                             popup.setPanMapIfOutOfView(true); //this set the popup in a strategic way, and pans the map if needed.
							                             popup.setAutoSize(true);
							                             //popup.setSize(size);
							                             map.addPopup(popup);
							                             drawChart();
							                         }

							                     });

							                     marker.addBrowserEventListener(EventType.MOUSE_OUT, new MarkerBrowserEventListener() {

							                         public void onBrowserEvent(MarkerBrowserEventListener.MarkerBrowserEvent markerBrowserEvent) {
							                             if(popup != null) {
							                                 map.removePopup(popup);
							                                 popup.destroy();
							                             }
							                         }

							                     });
						                     }
						                     //clusterStrategy.setFeatures(point_features);
						                     map.addLayer(layer);
						                     SelectFeature selectFeature = new SelectFeature(stationsLayer);
						                     selectFeature.setAutoActivate(true);
						                     map.addControl(selectFeature);
							            	  
							            } else {
							              // Handle the error.  Can get the status text from response.getStatusText()
							            	//resp.setText("Error occured"+response.getStatusCode());
							            }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void getFeatures(String url)
					{
					RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
				try {
			      builder.sendRequest(null,new RequestCallback() {

			        public void onError(Request request, Throwable exception) {
			        	
			        }
					public void onResponseReceived(Request request, Response response) {
			            System.out.println(response.getStatusCode());
			            System.out.println("Hi");
						if (200 == response.getStatusCode()) {
							xmlResponse = response.getText();
							publishAlert(xmlResponse);
			            }
					}
				});
				}
				catch(Exception e)
			      {
			    	  System.out.println(e);
			      }
					}
					public static void describeSensors(String url)
					{
					RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
				try {
			      builder.sendRequest(null,new RequestCallback() {

			        public void onError(Request request, Throwable exception) {
			        	
			        }
					public void onResponseReceived(Request request, Response response) {
			            System.out.println(response.getStatusCode());
			            System.out.println("Hi");
						if (200 == response.getStatusCode()) {
							xmlResponse = response.getText();
							publishAlert(xmlResponse);
			            }
					}
				});
				}
				catch(Exception e)
			      {
			    	  System.out.println(e);
			      }
					}
					public static void getObsTemp(String url)
					{
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						//builder.setTimeoutMillis(15000);
						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                    // System.out.println(xmlstr);
							            	 
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     
						                     String latt = null;
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("values").item(0).getFirstChild().getNodeValue());
						                            //System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt = stationsLatLonList.get(i);
						                            passObservation = latt;
						                            System.out.println(passObservation);
						                            //publishObservationValue();
						                            //System.out.println(latt);
						                        }
						                        String observations[] = latt.split("@");
						                        String str = "";
						                        for (int i = 0; i < observations.length; i++)
						                        {
						                        	str += observations[i] + "\n";
						                        }
						                        publishObservationValue(str);
						                     }
						                     }
							            else {
							              }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void getObsPrecipitation(String url)
					{
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						//builder.setTimeoutMillis(15000);
						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                    // System.out.println(xmlstr);
							            	 
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     
						                     String latt = null;
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("values").item(0).getFirstChild().getNodeValue());
						                            //System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt = stationsLatLonList.get(i);
						                            passObservation = latt;
						                            System.out.println(passObservation);
						                            //publishObservationValue();
						                            //System.out.println(latt);
						                        }
						                        String observations[] = latt.split("@");
						                        String str = "";
						                        for (int i = 0; i < observations.length; i++)
						                        {
						                        	str += observations[i] + "\n";
						                        }
						                        publishPrecipitationValue(str);
						                     }
						                     }
							            else {
							              }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void getObsPressure(String url)
					{
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						//builder.setTimeoutMillis(15000);
						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                    // System.out.println(xmlstr);
							            	 
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     
						                     String latt = null;
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("values").item(0).getFirstChild().getNodeValue());
						                            //System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt = stationsLatLonList.get(i);
						                            passObservation = latt;
						                            System.out.println(passObservation);
						                            //publishObservationValue();
						                            //System.out.println(latt);
						                        }
						                        String observations[] = latt.split("@");
						                        String str = "";
						                        for (int i = 0; i < observations.length; i++)
						                        {
						                        	str += observations[i] + "\n";
						                        }
						                        publishPressureValue(str);
						                     }
						                     }
							            else {
							              }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void getObsEvapo(String url)
					{
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						//builder.setTimeoutMillis(15000);
						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                    // System.out.println(xmlstr);
							            	 
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     
						                     String latt = null;
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("values").item(0).getFirstChild().getNodeValue());
						                            //System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt = stationsLatLonList.get(i);
						                            passObservation = latt;
						                            System.out.println(passObservation);
						                            //publishObservationValue();
						                            //System.out.println(latt);
						                        }
						                        String observations[] = latt.split("@");
						                        String str = "";
						                        for (int i = 0; i < observations.length; i++)
						                        {
						                        	str += observations[i] + "\n";
						                        }
						                        publishEvapoValue(str);
						                     }
						                     }
							            else {
							              }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void getObsBoolean(String url, String gl, String value)
					{
						ggl = gl;
						valuee = value;
						RequestBuilder builder = new RequestBuilder(RequestBuilder.GET, url);
						builder.setHeader("Accept", "text/html,application/xhtml+xml,application/xml");
						//builder.setTimeoutMillis(15000);
						try {
							      builder.sendRequest(null,new RequestCallback() {

							        public void onError(Request request, Throwable exception) {
							        	//window.alert("Error Occured while sending request");
							        }

							        public void onResponseReceived(Request request, Response response) {
							            if (200 == response.getStatusCode()) {
							            	 xmlResponse = response.getText();
						                    // System.out.println(xmlstr);
							            	 
						                     final Document messageDom = XMLParser.parse(xmlResponse);
						                     
						                     String latt = null;
									stationsLatLonList = new ArrayList<String>();
						                     //stationNamesList= new ArrayList<String>();
						                     systems=messageDom.getElementsByTagName("Observation");
						                     if(systems.item(0).hasChildNodes())
						                     {
						                    	 System.out.println("Has Child");
						                        for(int i=0;i<systems.getLength();i++)
						                        {
						                        	stationsLatLonList.add(((Element)systems.item(i)).getElementsByTagName("values").item(0).getFirstChild().getNodeValue());
						                            //System.out.println("Hi station: " +stationsLatLonList.get(i));
						                            latt = stationsLatLonList.get(i);
						                            passObservation = latt;
						                            System.out.println(passObservation);
						                            //publishObservationValue();
						                            //System.out.println(latt);
						                        }
						                        String observations[] = latt.split("@");
						                        String str = "";
						                        int flag = 0;
						                        for (int i = 0; i < observations.length; i++)
						                        {
						                        	flag = 0;
						                        	String str1[] = observations[i].split(",");
						                        	if (ggl.equalsIgnoreCase("Greaterthan"))
						                        	{
						                        		if (Double.parseDouble(str1[1]) > Double.parseDouble(valuee))
						                        			flag = 1;
						                        	}
						                        	else
						                        	{
						                        		if (Double.parseDouble(str1[1]) < Double.parseDouble(valuee))
						                        			flag = 1;
						                        	}
						                        	if (flag == 1)
						                        		str += observations[i] + "\n";
						                        }
						                        publishValue(str);
						                     }
						                     }
							            else {
							              }
							        }
							      });
							    } catch (RequestException e) {
							      System.out.println("Failed to send the request: " + e.getMessage());
							    }
					}
					public static void drawChart()
					{
						Window.enableScrolling(false);
						Window.setMargin("0px");
						ChartLoader chartLoader = new ChartLoader(ChartPackage.CORECHART);
						chartLoader.loadApi(new Runnable() {
						@Override
						public void run() {
						getSimpleLayoutPanel().setWidget(getPieChart());
						drawPieChart();
						}
						});
					}
					static Widget getPieChart() {
						
						return pieChart != null ? pieChart : new PieChart();
						}

					 static SimpleLayoutPanel getSimpleLayoutPanel() {
						return layoutPanel != null ? layoutPanel : new SimpleLayoutPanel();
						}
					 private static void drawPieChart() {
						 
						 DataTable dataTable = DataTable.create();

						  dataTable.addColumn(ColumnType.STRING, "Subject");

						  dataTable.addColumn(ColumnType.NUMBER, "Number of students");

						  dataTable.addRows(4);

						  dataTable.setValue(0, 0, "History");

						  dataTable.setValue(1, 0, "Computers");

						  dataTable.setValue(2, 0, "Management");

						  dataTable.setValue(3, 0, "Politics");

						  dataTable.setValue(0, 1, 20);

						  dataTable.setValue(1, 1, 25);

						  dataTable.setValue(2, 1, 30);

						  dataTable.setValue(3, 1, 35);
						 pieChart.draw(dataTable);
						 }

}