package events
{
	import flash.events.Event;
	
	import vo.Config;
	
	public class ConfigEvent extends Event
	{
		public static const DISABLE_CHECK_FOR_UPDATE_BUTTON:String = "DisableCheckForUpdateButtonConfigEvent";
		public static const OPEN_CONFIG_WINDOW:String = "OpenConfigWindowConfigEvent";
		public static const CONFIG_WINDOW_CLOSED:String = "ConfigWindowClosedConfigEvent";
		public static const SAVE_CONFIG:String = "SaveConfigConfigEvent";
		
		public var config:Config;
		
		public function ConfigEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}