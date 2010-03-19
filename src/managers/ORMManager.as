package managers
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import info.noirbizarre.airorm.ORM;
	
	import vo.AlertSound;
	
	public class ORMManager extends ManagerBase
	{
		public function ORMManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function initORM():void{
			ORM.registerClass(AlertSound);
			ORM.updateDB();
			
			var alertSound:AlertSound = new AlertSound();
			alertSound.canBeDeleted = false;
			alertSound.file_name = "take_your_damn_warfish_turn.mp3";
			alertSound.pretty_name = "Default Alert";
			alertSound.isSelected = true;
			alertSound.save();
			
			
			dispatchEvent(new Event("ormInitComplete"));
		}
		
		/*[Bindable (event="ormInitComplete")]
		public function get alertSounds():Array{
			
		}*/
	}
}