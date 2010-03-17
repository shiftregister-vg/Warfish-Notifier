package events
{
	import flash.events.Event;
	
	public class AlertEvent extends Event
	{
		public static const SHOW_ALERT:String = "ShowAlertAlertEvent";
		public static const PLAY_SOUND:String = "PlaySoundAlertEvent";
		public static const STOP_INTERVAL:String = "StopIntervalAlertEvent";
		
		public function AlertEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}