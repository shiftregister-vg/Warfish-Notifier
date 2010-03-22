package managers
{
	import events.IconMenuEvent;
	import events.RequestManagerEvent;
	
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.core.Window;
	
	import vo.Config;
	
	public class RequestManager extends ManagerBase
	{
		public var config:Config;
		private var rssXML:XML;
		private var requestDelay:int = 30000;
		private var requestInterval:int;
		
		public function RequestManager(){
			
		}
		
		public function startRequestInterval():void{
			if (config.rssURL.length){
				requestInterval = setInterval(function():void{
					getRSSFeed();
				},requestDelay);
			}
		}
		
		public function stopRequestInterval():void{
			clearInterval(requestInterval);
			requestInterval = 0;
		}
		
		public function getRSSFeed():void{
			if (config && config.rssURL.length){
				var urlRequest:URLRequest = new URLRequest(config.rssURL);
				urlRequest.contentType = "text/xml";
				urlRequest.method = URLRequestMethod.GET;
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE,onRequestComplete);
				loader.addEventListener(IOErrorEvent.IO_ERROR,onRequestError);
				loader.load(urlRequest);
			}
		}
		
		private function onRequestComplete(event:Event):void{
			var e:IconMenuEvent;
			var loader:URLLoader = URLLoader(event.target);
			rssXML = XML(loader.data);
			
			var isTurn:Boolean = false;
			if (rssXML..item.length() > 1){
				isTurn = true;
			}
			
			if (!isTurn){
				
				dispatchEvent(new IconMenuEvent(IconMenuEvent.SET_ICON));
				
				e = new IconMenuEvent(IconMenuEvent.REMOVE_MENU_BY_LABEL);
				e.menuLabel = "Games";
				dispatchEvent(e);
				
				dispatchEvent(new RequestManagerEvent(RequestManagerEvent.NO_TURNS));
			} else {
				var gamesMenuItem:NativeMenuItem = new NativeMenuItem("Games");
				var gamesMenu:NativeMenu = new NativeMenu();
				for (var i:int = 0; i < rssXML..item.length(); i++){
					if (rssXML..item[i].title.toString() != "View Your Turn Games list"){
						var gameMenu:NativeMenuItem = gamesMenu.addItem(new NativeMenuItem(rssXML..item[i].title.toString().replace(" [Your turn]","")));
						gameMenu.data = {url:rssXML..item[i].link.toString()};
						gameMenu.addEventListener(Event.SELECT,function(event:Event):void{
							navigateToURL(new URLRequest(event.target.data.url));
						});
					}
				}
				if (gamesMenu.items.length){
					gamesMenuItem.submenu = gamesMenu;
					e = new IconMenuEvent(IconMenuEvent.ADD_MENU_ITEM);
					e.iconMenu = gamesMenuItem;
					e.iconPosition = 1;
					dispatchEvent(e);
				}
				
				if (config.blinkIconOnTurn){
					dispatchEvent(new IconMenuEvent(IconMenuEvent.BLINK_ICON));
				} else {
					e = new IconMenuEvent(IconMenuEvent.SET_ICON);
					e.iconName = "-red";
					e.toolTip = " - It's your turn!";
					dispatchEvent(e);
				}
				
				dispatchEvent(new RequestManagerEvent(RequestManagerEvent.HAS_TURNS));
			}
		}
		private function onRequestError(event:IOErrorEvent):void{
			var e:RequestManagerEvent = new RequestManagerEvent(RequestManagerEvent.REQUEST_ERROR);
			e.message = "There was a problem communicating with Warfish.net.  Verify your RSS URL and that Warfish.net is available and try again.";
			dispatchEvent(e);
		}
	}
}