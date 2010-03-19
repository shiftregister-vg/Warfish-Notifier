package managers
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import vo.WarfishConfig;
	
	public class SoundManager extends ManagerBase
	{
		public var warfishConfig:WarfishConfig;
		[Bindable][Embed(source="/assets/sound/take-your-damn-warfish-turn.mp3")]
		private var alertSoundClass:Class;
		private var soundEmbed:Sound = new alertSoundClass() as Sound;
		private var soundChannel:SoundChannel;
		
		public function SoundManager(){
			
		}
		
		public function playSound():void{
			if (warfishConfig.playSound){
				SoundMixer.soundTransform = new SoundTransform(1);
				soundChannel = soundEmbed.play();
			}
		}
		
		public function saveSounds(value:Array):void{
			warfishConfig.sounds = value;
			dispatchEvent(new Event("soundsChanged"));
		}
		
		[Bindable (event="soundsChanged")]
		public function get sounds():Array{
			return warfishConfig.sounds;
		}
	}
}