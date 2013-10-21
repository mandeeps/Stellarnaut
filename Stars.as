package
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;

	/**
	 * implements a simple starfield
	 * @author Richard Marks
	 */
	public class Stars extends Graphic
	{
		// stars is [star1, star2, star3, etc]
		// star# is [graphic, x, y, color, speed]
		private var stars:Array;

		// number of stars
		private var fieldDensity:int;
		private var fieldColors:Array;

		override public function update():void
		{
			// move stars from the bottom of the screen to the top
			for each(var star:Array in stars)
			{
				// add speed to the star
				// EDIT by Manu += instead of -=
				star[2] += star[4];

				if (star[2] > FP.screen.height)
				{
					// new random x position and warp back to bottom
					star[1] = Math.random() * FP.width;
					star[2] = 0;
				}
			}
		}

		override public function render(target:BitmapData, point:Point, camera:Point):void
		{
			for each(var star:Array in stars)
			{
				//(star[0] as Image).render(new Point(star[1], star[2]), camera);
				//(star[0] as Image).render(FP.buffer, new Point(star[1], star[2]), camera);  // This line.
				(star[0] as Image).render(target, new Point(star[1], star[2]), camera);
			}
		}

		/**
		 * creates a new starfield
		 * @param	density - number of stars
		 * @param	colors - an array of unsigned integers for each star color depth
		 */
		public function Stars(density:int = 400, colors:Array = null)
		{
			if (colors == null)
			{
				colors = [0x444444, 0x999999, 0xBBBBBB, 0xFFFFFF, ];//0xCC0099, 0x0066CC];
			}

			if (density > 1000)
			{
				density = 1000;
			}

			fieldDensity = density;
			fieldColors = colors;
			active = true;
			visible = true;

			CreateField();
		}

		// creates the starfield
		private function CreateField():void
		{
			// new array of stars
			stars = new Array;

			for (var i:int = 0; i < fieldDensity; i++)
			{
				// star is [graphic, x, y, color, speed]
				var star:Array = [null, null, null, null, null];

				// random position
				star[1] = Math.random() * FP.width;
				star[2] = Math.random() * FP.height;

				// random speed based on number of available colors
				star[4] = Math.floor(Math.random() * fieldColors.length);

				// color based on speed
				star[3] = fieldColors[star[4]];

				// star graphic itself
				star[0] = Image.createRect(1, 1, star[3]);

				// add star to the stars array
				stars.push(star);
			}
		}
	}
}
