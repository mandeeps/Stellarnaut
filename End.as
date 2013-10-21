// Stellarnaut End Screen

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class End extends World {
		[Embed(source = "assets/alien.ttf", embedAsCFF = "false", fontFamily = "space")]
		private var font:Class;

		override public function begin():void {
			Text.font = "space"
			var myText:Text = new Text("You have defeated the alien mothership",0,130,745,52);
			myText.x = int(FP.screen.width/2 - myText.width/2 - 120);
			myText.color = 0xFFFFFF;
			myText.size = 32;
			var myTextEntity:Entity = new Entity(0, 0, myText);
			add(myTextEntity);
			var instructText:Text = new Text("and avenged your fallen comrades!",0,160,745,52);
			instructText.x = int(FP.screen.width/2 - instructText.width/2 - 120);
			instructText.color = 0xFFFFFF;
			instructText.size = 32;
			var instructTextEntity:Entity = new Entity(0, 0, instructText);
			add(instructTextEntity);

			var scoreText:Text = new Text("Try Again for a higher Score than " + String(SWorld.score),0,220,745,52);
			scoreText.x = int(FP.screen.width/2 - scoreText.width/2 - 120);
			scoreText.color = 0xFFFFFF;
			scoreText.size = 32;
			var scoreTextEntity:Entity = new Entity(0, 0, scoreText);
			add(scoreTextEntity);

			//var playAgainText:Text = new Text("Press enter to play again",0,260,745,52);
			//playAgainText.x = int(FP.screen.width/2 - playAgainText.width/2 - 80);
			//playAgainText.color = 0xFFFFFF;
			//playAgainText.size = 32;
			//var playAgainTextEntity:Entity = new Entity(0, 0, playAgainText);
			//add(playAgainTextEntity);

			var rewardText:Text = new Text("Enemy Art by Skorpio. Music by maxstack.",0,300,745,52);
			rewardText.x = int(FP.screen.width/2 - rewardText.width/2 - 80);
			rewardText.color = 0xFFFFFF;
			rewardText.size = 24;
			var rewardTextEntity:Entity = new Entity(0, 0, rewardText);
			add(rewardTextEntity);

			add(new ShergillGames);
			super.begin();
		}

		public function End() {
		}

		override public function render():void {
			super.render();
		}

		//override public function update():void {
			//if (Input.pressed(Key.ENTER)) {
				//Player.killed = false;
				//Bullet.bw = Bullet.initBW;
				//Player.tempShield = true;
				//Player.hp = 5;
				//SWorld.nopowerUp = true;
				////world.add(new LifeBar);
				////world.add(new Player);
				//HUD.gameOverText1.text = ""
				//HUD.gameOverText2.text = ""
				//HUD.gameOver = false;
				//SWorld.score = 0;
				////Boss.health = 30;
				//FP.world = new SWorld;
			//}
		//}

	}
}
