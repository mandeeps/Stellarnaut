package
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class LifeBar extends Entity
    {
        public var bar:Image = Image.createRect(((Player.hp-1)*5),10, 0x0000FF);

        public function LifeBar()
        {
			layer = -2;
            super(80, FP.height-15, bar);
        }

        override public function update():void
        {
            if (Player.hpIncrease)
            {
                bar.clipRect.width = FP.approach(bar.clipRect.width, bar.width, 5);
                bar.clear();
                bar.updateBuffer();
                Player.hpIncrease = false;
            }
            if (Player.hpDecrease)
            {
                bar.clipRect.width = FP.approach(bar.clipRect.width, 0, 5);
                bar.clear();
                bar.updateBuffer();
                Player.hpDecrease = false;
            }
        }
    }
}
