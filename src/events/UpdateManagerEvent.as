package events
{
	import flash.events.Event;
	
	public class UpdateManagerEvent extends Event
	{
		public static const NO_UPDATE_AVAILABLE:String = "NoUpdateAvailableUpdateManagerEvent";
		public static const AUTO_CHECK_FOR_UPDATE:String = "AutoCheckForUpdateUpdateManagerEvent";
		public static const CHECK_FOR_UPDATE_MANUAL:String = "CheckForUpdateManualUpdateManagerEvent";
		
		public function UpdateManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}