/*
 * Main.eq
 * Generated by Eqela Studio 2.0b7.4
 */

public class Main : SEScene
{
	SESprite bg;
	SESprite fg;
	SESprite text;
	
	bool move_right = true;
	bool move_left = false;
	bool move_up = false;
	bool move_down = true;
	int speed = 50;
	double rotation;
	String display;
	int bounce = 0;
	
	public void initialize(SEResourceCache rsc)
	 {
		base.initialize(rsc);
		bg = add_sprite_for_color(Color.instance("black"),get_scene_width(),get_scene_height());
		bg.move(0,0);
		
		//fg = add_sprite_for_color(Color.instance("#E6E600"),get_scene_width()*0.1,
	//	get_scene_height()*0.1);
		
	//	fg.move(100,100);

		rsc.prepare_font("myfont","verdana bold color=white",40);
		display = "Bounces = %d".printf().add(Primitive.for_integer(bounce)).to_string();
		text = add_sprite_for_text(display, "myfont");
		text.move(0,get_scene_height() - text.get_height());
		rsc.prepare_image("myimage","index", get_scene_width()*0.1);
		fg = add_sprite_for_image(SEImage.for_resource("myimage"));
		fg.move(100,100);
	 }

	public void update(TimeVal now, double delta)
	{
		base.update(now, delta);
		speed += 100;
		rotation += MathConstant.M_PI_4/8;
		fg.set_rotation(rotation);
		if(move_right)
		{
			fg.move(fg.get_x() + delta * speed, fg.get_y()); 
			if(fg.get_x() + fg.get_width() > get_scene_width())
			{
				speed = 50;
				bounce++;
				display = "Bounces = %d".printf().add(Primitive.for_integer(bounce)).to_string();
				text.set_text(display);
				
				move_right = false;
				move_left = true;
			}
		//	if(fg.get_y() + fg.get_height() > get_scene_width)
		}

		if(move_left)
		{
			fg.move(fg.get_x() - delta * speed,fg.get_y());
			if(fg.get_x() < 0)
			{
				speed = 50;
				bounce++;
				display = "Bounces = %d".printf().add(Primitive.for_integer(bounce)).to_string();;
				text.set_text(display);
				
				move_right = true;
				move_left = false;
			}
			
		}

		if(move_up)
		{
			fg.move(fg.get_x(), fg.get_y() - delta *speed);
			if(fg.get_y() < 0)
			{
				speed = 50;
				bounce++;
				display = "Bounces = %d".printf().add(Primitive.for_integer(bounce)).to_string();
				text.set_text(display);
				
				move_down = true;
				move_up = false;
			}
		}

		if(move_down)
		{
			fg.move(fg.get_x() + delta*100, fg.get_y() + delta * speed);
			if(fg.get_y() + fg.get_height() > get_scene_height())
			{
				speed = 50;
				bounce++;
				display = "Bounces = %d".printf().add(Primitive.for_integer(bounce)).to_string();
				text.set_text(display);
				
				move_up = true;
				move_down = false;
			}
		}

	}

	
	public void set_rotation(double angle)
	{
		rotation = angle;
	}

	public void cleanup()
	{
		base.cleanup();
		SESprite.remove(fg);
		SESprite.remove(bg);
		SESprite.remove(text);
	}
}