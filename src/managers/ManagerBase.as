package managers
{
	import com.asfusion.mate.events.Dispatcher;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ManagerBase extends EventDispatcher
	{
		protected var dispatcher:Dispatcher = new Dispatcher();
		
		public function ManagerBase(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		override public function dispatchEvent(event:Event):Boolean{
			dispatcher.dispatchEvent(event);
			super.dispatchEvent(event);
			return true;
		}
	}
}