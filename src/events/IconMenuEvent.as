package events
{
	import flash.events.Event;
	
	public class IconMenuEvent extends Event
	{
		public static const EXIT_MENU_SELECTED:String = "ExitMenuSelectedIconMenuEvent";
		public static const CONFIG_MENU_SELECTED:String = "ConfigMenuSelectedIconMenuEvent";
		public static const OPEN_WARFISH_SELECTED:String = "OpenWarfishSelectedIconMenuEvent";
		public static const ENABLE_SOUND_SELECTED:String = "EnableSoundSelectedIconMenuEvent";
		
		public function IconMenuEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}