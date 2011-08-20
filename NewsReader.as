package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class NewsReader extends Sprite {
		private var nodes:Array;
		private var easing:Number = 0.3;
		private var news:XML;
		private var tip:Tip;
		private var incPos:Number;
		private var incAngle:Number;
		private var angle:Number = 0;
		private var radiusX:Number = 200;
		private var radiusY:Number = 100;
		private var centerX:Number = stage.stageWidth / 2;
		private var centerY:Number = stage.stageHeight / 2;
		private var existsEnlarged:Boolean = false;

		public function NewsReader() {
			init();
		}
		
		private function init():void {
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			tip = new Tip();
			tip.visible = false;
			addChild(tip);
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadXML);
			loader.load(new URLRequest("news.xml"));
		}
		
		private function onLoadXML(event:Event):void {	
			news = new XML(event.target.data);
			news.ignoreWhitespace = true;

			var countNews:int = news.nodo.length();
			incPos = 360 / countNews;

			nodes = new Array();

			for (var i:int = 0; i < countNews; i++) {
				var title:String = news..title[i];
				var subtitle:String = news..subtitle[i];
				var content:String = news..content[i];

				nodes[i] = new Node(title, subtitle, content);
				addChild(nodes[i]);

				nodes[i].buttonMode = true;
				nodes[i].cacheAsBitmap = true;
				
				nodes[i].addEventListener(MouseEvent.CLICK, onClick);
				nodes[i].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
		}
		private function onClick(event:MouseEvent):void {
			var node:Node = Node(event.target.parent);

			if (node.scaleX != 1.0 && node.scaleY != 1.0) {
				if (!existsEnlarged) {
					tip.visible = false;
					existsEnlarged = true;
					setChildIndex(node, numChildren - 1);
					node.addEventListener(Event.ENTER_FRAME, enlarge);
					stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			} else {
				node.addEventListener(Event.ENTER_FRAME, reduce);
			}
		}
		private function enlarge(event:Event):void {
			var node:Node = Node(event.target);

			var targetScale:Number = 1.0;
			var targetAlpha:Number = 1.0;
			var diffScaleX:Number = Math.abs(node.scaleX - targetScale);
			var diffScaleY:Number = Math.abs(node.scaleY - targetScale);
			var diffAlpha:Number = Math.abs(targetAlpha - node.alpha);
			var dx:Number = stage.stageWidth / 2 - node.x;
			var dy:Number = stage.stageHeight / 2 - node.y;

			node.scaleX += diffScaleX * easing;
			node.scaleY += diffScaleY * easing;
			node.alpha += diffAlpha * easing;
			node.x += dx * easing;
			node.y += dy * easing;

			if (diffScaleX < 0.01  && diffScaleY < 0.01) {
				node.scaleX = node.scaleY = 1.0;
				node.alpha = 1.0;
				node.removeEventListener(Event.ENTER_FRAME, enlarge);
			}
		}
		private function reduce(event:Event):void {
			var node:Node = Node(event.target);

			var targetScale:Number = node.lastScaleX;
			var targetAlpha:Number = node.lastAlpha;
			var diffScaleX:Number = Math.abs(node.scaleX - targetScale);
			var diffScaleY:Number = Math.abs(node.scaleY - targetScale);
			var diffAlpha:Number = Math.abs(targetAlpha - node.alpha);
			var dx:Number = node.lastX - node.x;
			var dy:Number = node.lastY - node.y;

			node.scaleX -= diffScaleX * easing;
			node.scaleY -= diffScaleY * easing;
			node.alpha -= diffAlpha * easing;
			node.x += dx * easing;
			node.y += dy * easing;

			if (diffScaleX < 0.01  && diffScaleY < 0.01) {
				node.scaleX = node.lastScaleX;
				node.scaleY = node.lastScaleY;
				node.alpha = node.lastAlpha;
				node.removeEventListener(Event.ENTER_FRAME, reduce);
				stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				existsEnlarged = false;
			}
		}
		private function onMouseOver(event:MouseEvent):void {
			if (event.target.parent is Node) {
				var node:Node = Node(event.target.parent);
				if (node.alpha < 1.0) {
					tip.visible = true;
					this.setChildIndex(tip, numChildren - 1);
					tip.txt = node.title;

					tip.addEventListener(Event.ENTER_FRAME, tipFollowMouse);
					node.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				}
			}
		}
		private function onMouseOut(event:MouseEvent):void {
			tip.visible = false;
			tip.addEventListener(MouseEvent.MOUSE_MOVE, tipFollowMouse);
		}
		private function tipFollowMouse(event:Event):void {
			tip.x = stage.mouseX + 15;
			tip.y = stage.mouseY;
		}
		private function onEnterFrame(event:Event):void {
			incAngle = (stage.stageWidth / 2 - stage.mouseX) / 200;
			
			for (var i:int = 0; i < nodes.length; i++) {
				nodes[i].x = centerX + Math.cos(angle * Math.PI / 180) * radiusX;
				nodes[i].y = centerY + Math.sin(angle * Math.PI / 180) * radiusY;

				nodes[i].scaleX = .2 + .1 * Math.sin(angle * Math.PI / 180);
				nodes[i].scaleY = .2 + .1 * Math.sin(angle * Math.PI / 180);
				nodes[i].alpha = .5 + .3 * Math.sin(angle * Math.PI / 180);

				nodes[i].lastX = nodes[i].x;
				nodes[i].lastY = nodes[i].y;
				nodes[i].lastScaleX = nodes[i].scaleX;
				nodes[i].lastScaleY = nodes[i].scaleY;
				nodes[i].lastAlpha = nodes[i].alpha;

				angle += incPos;
				angle += incAngle;
			}
		}
		private function onResize(event:Event):void {
			centerX = stage.stageWidth / 2;
			centerY = stage.stageHeight / 2;
		}
	}
}