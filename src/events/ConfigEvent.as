package events
{
	import flash.events.Event;
	
	public class ConfigEvent extends Event
	{
		public static const DISABLE_CHECK_FOR_UPDATE_BUTTON:String = "DisableCheckForUpdateButtonConfigEvent";
		public static const OPEN_CONFIG_WINDOW:String = "OpenConfigWindowConfigEvent";
		public static const CONFIG_WINDOW_CLOSED:String = "ConfigWindowClosedConfigEvent";
		
		public function ConfigEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}