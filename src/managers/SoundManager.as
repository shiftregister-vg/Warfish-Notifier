package managers
{
	import events.ConfigEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import mx.core.SoundAsset;
	
	import vo.AlertSound;
	import vo.Config;
	
	public class SoundManager extends ManagerBase
	{
		public var config:Config;
		
		public function SoundManager(){
			
		}
		
		public function playSound():void{
			var sound:Sound = new Sound();
			var soundChannel:SoundChannel;
			if (config.playSound){
				var soundFile:String = config.defaultSound.file_name;
				if (!config.playDefaultSound){
					for (var i:int=0;i < config.sounds.length; i++){
						if (config.sounds[i].isSelected){
							soundFile = config.sounds[i].file_name;
							break;
						}
					}
				}
				SoundMixer.soundTransform = new SoundTransform(1);
				sound.load(new URLRequest(soundFile));
				soundChannel = sound.play();
			}
		}
		
		public function saveSounds(value:Array):void{
			config.sounds = value;
			dispatchEvent(new Event("soundsChanged"));
			var e:ConfigEvent = new ConfigEvent(ConfigEvent.SAVE_CONFIG);
			e.config = config;
			dispatchEvent(e);
		}
		
		[Bindable (event="soundsChanged")]
		public function get sounds():Array{
			return config.sounds;
		}
		
		public function addAlertSound(alertSound:AlertSound):void{
			config.sounds.push(alertSound);
			saveSounds(config.sounds);
		}
	}
}