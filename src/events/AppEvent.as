package events
{
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		public static const CREATION_COMPLETE:String = "CreationCompleteAppEvent";
		
		public function AppEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}