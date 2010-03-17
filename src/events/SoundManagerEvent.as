package events
{
	import flash.events.Event;
	
	public class SoundManagerEvent extends Event
	{
		public static const OPEN_SOUND_MANAGER_WINDOW:String = "OpenSoundManagerWindowSoundManagerEvent";
		
		public function SoundManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}