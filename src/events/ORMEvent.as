package events
{
	import flash.events.Event;
	
	public class ORMEvent extends Event
	{
		public static const INIT:String = "InitORMEvent";
		
		public function ORMEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}