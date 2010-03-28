package managers
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	
	import com.asfusion.mate.events.Dispatcher;
	
	import events.UpdateManagerEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.setInterval;
	
	import mx.controls.Alert;

	public class UpdateManager extends ManagerBase
	{
		private var manifestURL:String = "http://update.slantsoft.com/warfishnotification/manifest.xml";
		private var manifest:XML;
		
		public function UpdateManager(){
			var updateInterval:int = setInterval(function(event:Event=null):void{
				checkForUpdate();
			},7200000);
		}
		
		public function checkForUpdate():void{
			trace('checkForUpdate()');
			var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
			appUpdater.updateURL = manifestURL + "?" + Math.random().toString() + "=" + Math.random().toString();
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.addEventListener(UpdateEvent.INITIALIZED,onUpdate);
			appUpdater.addEventListener(ErrorEvent.ERROR,onError);
			appUpdater.initialize();
		}
		
		private function onUpdate(event:UpdateEvent):void{
			var appUpdater:ApplicationUpdaterUI = event.target as ApplicationUpdaterUI;
			appUpdater.checkNow();
		}
		
		public function manualCheckForUpdate():void{
			trace('manualCheckForUpdate()');
			var urlRequest:URLRequest = new URLRequest(manifestURL + "?" + Math.random().toString() + "=" + Math.random().toString());
			urlRequest.contentType = "text/xml";
			urlRequest.method = URLRequestMethod.GET;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onManualCheckForUpdateRequestComplete);
			loader.load(urlRequest);
		}
		
		private function onManualCheckForUpdateRequestComplete(event:Event):void{
			var loader:URLLoader = URLLoader(event.target);
			var xmlnsPattern:RegExp = new RegExp("xmlns[^\"]*\"[^\"]*\"", "gi");
			manifest = XML(XML(loader.data).toXMLString().replace(xmlnsPattern,""));
			if (manifest.version <= getAppVersion()){
				dispatchEvent(new UpdateManagerEvent(UpdateManagerEvent.NO_UPDATE_AVAILABLE));
			} else {
				checkForUpdate();
			}
		}
		
		private function onError(event:ErrorEvent):void{
			Alert.show(event.toString());
		}
		
		private function getAppVersion():String {
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			var appVersion:String = appXml.ns::version[0];
			return appVersion;
		}
	}
}