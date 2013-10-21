package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import mochi.as3.*;
	import Math;

	public class HUD extends Entity {
		[Embed(source = "assets/alien.ttf", embedAsCFF='false', fontFamily = "space")]
		private var font:Class;
		public static var shieldText:Text;
		public static var scoreText:Text;
		public static var gameOverText1:Text;
		public static var gameOverText2:Text;
		public static var gameOverText3:Text;
		private var display:Graphiclist;
		public static var gameOver:Boolean = false;
		public var mochiScoreSubmitted:Boolean = false;
		public var ID:String = "6f9dede6a43b2f76";
//		public static var playCount:int = 1;
//		public static var endLevel:int = 3;
		public static var musicLooped:Boolean = false;
		public static var gameWon:Boolean = false;
		public static var kong:Boolean = false;
		private var lastSubmittedScore:Number = 0;

		public function HUD() {
			if (checkDomain("kongregate.com")) {kong = true;}

			layer = -2

			shieldText = new Text("Shield: " + String(Player.hp-1), 0, FP.screen.height-20,385,70);
			shieldText.font = "space";
			shieldText.color = 0xFFFFFF;
			shieldText.size = 20;

			scoreText = new Text("Mothership ETA: " + String(180 - Math.floor(SWorld.time/24)) + "   Score: " + String(SWorld.score), (FP.screen.width -350), FP.screen.height-20,385,70);
			scoreText.font = "space";
			scoreText.color = 0xFFFFFF;
			scoreText.size = 20;

			gameOverText1 = new Text("",140,90,700,52);
			gameOverText1.font = "space";
			gameOverText1.color = 0xFFFFFF;
			gameOverText1.size = 26;

			gameOverText2 = new Text("",140,120,700,52);
			gameOverText2.font = "space";
			gameOverText2.color = 0xFFFFFF;
			gameOverText2.size = 26;

			gameOverText3 = new Text("",60,180,700,52);
			gameOverText3.font = "space";
			gameOverText3.color = 0xFFFFFF;
			gameOverText3.size = 32;

			display = new Graphiclist(shieldText,scoreText,gameOverText1,gameOverText2,gameOverText3);
			graphic = display
		}

		override public function update():void {
			if (Player.hp > 0) {shieldText.text = "Shield: " + String(Player.hp-1);}
			if (180 - Math.floor(SWorld.time/24) > 0) {scoreText.text = "Mothership ETA: " + String(180 - Math.floor(SWorld.time/24)) + "   Score: " + String(SWorld.score);}
			else {scoreText.text = "Mothership Contact!   " + "Score: " + String(SWorld.score);}

			if (gameOver) {
				if (!mochiScoreSubmitted /**&& SWorld.score > lastSubmittedScore ||**/ && gameWon) {
					var o:Object = { n: [7, 4, 11, 4, 8, 0, 12, 10, 5, 9, 5, 12, 6, 8, 4, 3], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
					var boardID:String = o.f(0,"");
					MochiScores.showLeaderboard({boardID: boardID, score: SWorld.score});
					mochiScoreSubmitted = true;
					if (kong) {Kongregate.submit("Enemies Killed", SWorld.EnemyKillCount);}
					if (kong) {Kongregate.submit("Score", SWorld.score)};
				}
				if (Player.killed) {
					SWorld.score = 0;
				}

				if (Input.check(Key.ENTER) ){
//					if (playCount < endLevel) {
						Player.killed = false;
						Bullet.bw = Bullet.initBW;
						Player.tempShield = true;
						Player.oldY = 0;
						Player.hp = 5;
						SWorld.nopowerUp = true;
						world.add(new LifeBar);
						world.add(new Player);
						gameOverText1.text = ""
						gameOverText2.text = ""
						gameOverText3.text = ""
						gameOver = false;
//					}
				}
				if (gameWon) {
					FP.world = new End;
					MochiEvents.trackEvent("Game Beaten");
					if (kong) {Kongregate.submit("GameComplete", 1);}
				}
			}
		}


		public function checkDomain (allowed:*):Boolean {
			var url:String = FP.stage.loaderInfo.url;
			var startCheck:int = url.indexOf('://' ) + 3;
			if (url.substr(0, startCheck) == 'file://') return false;
			var domainLen:int = url.indexOf('/', startCheck) - startCheck;
			var host:String = url.substr(startCheck, domainLen);
			if (allowed is String) allowed = [allowed];
			for each (var d:String in allowed) {
				if (host.substr(-d.length, d.length) == d) return true;
			}
		return false;
		}

	}
}
