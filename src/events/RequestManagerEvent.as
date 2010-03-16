package events
{
	import flash.events.Event;
	
	public class RequestManagerEvent extends Event
	{
		public function RequestManagerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}