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
		private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		
		public function UpdateManager(){
			var updateInterval:int = setInterval(function(event:Event=null):void{
				checkForUpdate();
			},7200000);
		}
		
		public function checkForUpdate():void{
			if (!manifestURL){
				var manifestError:Error = new Error("manifestURL was not supplied");
				throw manifestError;
			} else {
				appUpdater.updateURL = manifestURL + "?rnd=" + Math.random();
				appUpdater.isCheckForUpdateVisible = false;
				appUpdater.addEventListener(UpdateEvent.INITIALIZED,onUpdate);
				appUpdater.addEventListener(ErrorEvent.ERROR,onError);
				appUpdater.initialize();
			}
		}
		
		private function onUpdate(event:UpdateEvent):void{
			appUpdater.checkNow();
		}
		
		public function manualCheckForUpdate():void{
			if (!manifestURL){
				var manifestError:Error = new Error("manifestURL was not supplied");
				throw manifestError;
			} else { 
				var urlRequest:URLRequest = new URLRequest(manifestURL + "?" + Math.random() + "=" + Math.random());
				urlRequest.contentType = "text/xml";
				urlRequest.method = URLRequestMethod.GET;
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE,onManualCheckForUpdateRequestComplete);
				trace("getting manifest");
				loader.load(urlRequest);
			}
		}
		
		private function onManualCheckForUpdateRequestComplete(event:Event):void{
			trace("request complete");
			var loader:URLLoader = URLLoader(event.target);
			var xmlnsPattern:RegExp = new RegExp("xmlns[^\"]*\"[^\"]*\"", "gi");
			manifest = XML(XML(loader.data).toXMLString().replace(xmlnsPattern,""));
			trace("version: " + manifest.version);
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