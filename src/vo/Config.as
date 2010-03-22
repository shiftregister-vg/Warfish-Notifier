package vo
{
	[Bindable][RemoteClass (alias="vo.Configuration")]
	public class Config
	{
		public var rssURL:String = "";
		public var playSound:Boolean = true;
		public var startOnLogin:Boolean = true;
		public var bubbleInterval:int = 10000;
		public var alertColor:uint = 0x3D004F;
		public var blinkIconOnTurn:Boolean = true;
		public var sounds:Array = new Array();
		public var playDefaultSound:Boolean = true;
		public var defaultSound:AlertSound;
		
		public function Config(){
			defaultSound = new AlertSound();
			defaultSound.file_name = "/assets/sound/take-your-damn-warfish-turn.mp3";
			defaultSound.pretty_name = "Default Sound";
		}
	}
}