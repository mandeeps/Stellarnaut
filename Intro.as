// Supernaut Intro Screen

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import mochi.as3.*;
	import net.flashpunk.Sfx;

	public class Intro extends World {
		[Embed(source = "assets/alien.ttf", embedAsCFF='false', fontFamily = "space")]
		private var font:Class;
		public static var musicStarted:Boolean = false;

		override public function begin():void {
			Text.font = "space";
			var myText:Text = new Text("You are the last survivor of your fleet",0,110,500,52);
			myText.x = int(FP.screen.width/2 - myText.width/2 - 80);
			myText.color = 0xFFFFFF;
			myText.size = 24;
			var myText2:Text = new Text("Pilot the advanced Avenger fighter",0,140,500,52);
			myText2.x = int(FP.screen.width/2 - myText2.width/2 -80);
			myText2.color = 0xFFFFFF;
			myText2.size = 24;
			var myText3:Text = new Text("Destroy the aliens who wiped out your friends!",0,170,500,52);
			myText3.x = int(FP.screen.width/2 - myText3.width/2 -80);
			myText3.color = 0xFFFFFF;
			myText3.size = 24;
			var myTextEntity:Entity = new Entity(0, 0, myText);
			add(myTextEntity);
			var myTextEntity2:Entity = new Entity(0, 0, myText2);
			add(myTextEntity2);
			var myTextEntity3:Entity = new Entity(0, 0, myText3);
			add(myTextEntity3);
			var instructText:Text = new Text("You will reach the alien mothership in 3 minutes",0,230,500,52);
			instructText.x = int(FP.screen.width/2 - instructText.width/2 -80);
			instructText.color = 0xFFFFFF;
			instructText.size = 24;
			var instructTextEntity:Entity = new Entity(0, 0, instructText);
			add(instructTextEntity);
			var closeText:Text = new Text("As you kill foes more powerful ones will attack",0,260,550,52);
			closeText.x = int(FP.screen.width/2 - closeText.width/2 -90);
			closeText.color = 0xFFFFFF;
			closeText.size = 24;
			var closeTextEntity:Entity = new Entity(0, 0, closeText);
			add(closeTextEntity);
//			var mothershipText:Text = new Text("",0,260,500,52);
//			mothershipText.x = int(FP.screen.width/2 - mothershipText.width/2 -30);
//			mothershipText.color = 0xFFFFFF;
//			mothershipText.size = 18;
//			var mothershipTextEntity:Entity = new Entity(0, 0, mothershipText);
//			add(mothershipTextEntity);

			add(new ShergillGames);
			add(new playButton);
			super.begin();
		}

		override public function render():void {
			super.render();
		}

		public function Intro() {
			if (!musicStarted) {SWorld.music.volume = 1.0; SWorld.music.loop(); musicStarted = true;}
			FP.screen.color = 0x000000;
		}

	}
}
