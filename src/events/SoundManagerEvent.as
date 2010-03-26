package events
{
	import flash.events.Event;
	
	import vo.AlertSound;
	
	public class SoundManagerEvent extends Event
	{
		public static const OPEN_SOUND_MANAGER_WINDOW:String = "OpenSoundManagerWindowSoundManagerEvent";
		public static const ADD_ALERT_SOUND:String = "AddAlertSoundSoundManagerEvent";
		public static const SAVE_SOUNDS:String = "SaveSoundsSoundManagerEvent";
		
		public var alertSound:AlertSound;
		public var sounds:Array;
		
		public function SoundManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}