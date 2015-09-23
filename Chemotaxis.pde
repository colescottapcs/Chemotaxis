import java.util.Iterator;

public static final int bacNum = 10;
ArrayList<Bacteria> bac = new ArrayList<Bacteria>();

Food f;

public final int RED = color(255,0,0);
public final int GREEN = color(0,255,0);
public final int BLUE = color(0,0,255);
public final int CYAN = color(0,255,255);
public final int MAGENTA = color(255,0,255);
public final int YELLOW = color(255,255,0);

void setup()   
{     
	f = new Food((int)(Math.random() * width), (int)(Math.random() * height));
	size(500,500);
	for(int i = 0; i < bacNum; i++)
	{
		bac.add(new Bacteria((int)(Math.random() * width), (int)(Math.random() * height), RED));
	}
}   
void draw()   
{    
	background(200);
	f.show();
	ArrayList<Bacteria> toAdd = new ArrayList<Bacteria>();
	Iterator<Bacteria> Ibac = bac.iterator();
	while(Ibac.hasNext())
	{
		Bacteria b = (Bacteria)Ibac.next();

		b.move();
		if(f.colliesWith(b))
		{
			b.size += f.size;
			f = new Food((int)(Math.random() * width), (int)(Math.random() * height));
		}
		if(b.size > b.maxSize && Math.random() < 0.05)
		{
			Bacteria ba = new Bacteria(b.x + (int)(Math.random() * 9) - 4, b.y + (int)(Math.random() * 9) - 4, RED);
			ba.size = (int)(b.size / 2);
			toAdd.add(ba);
			b.size = (int)(b.size / 2);
		}
		b.show();
		b.size *= 0.999;
		if(b.size < 0.5)
			Ibac.remove();
	}
	for(Bacteria b : toAdd)
	{
		bac.add(b);
	}
}  
class Food
{
	public int x = 0;
	public int y = 0;
	public int size = 0;
	public int c = 0;

	public Food(int x, int y)
	{
		this.x = x;
		this.y = y;
		size = (int)(Math.random() * 10 + 10);
		c = GREEN;
	}

	void show()
	{
		fill(c);
		ellipse(this.x, this.y, this.size, this.size);
	}

	boolean colliesWith(Bacteria b)
	{
		return Math.pow(b.x - this.x, 2) + Math.pow(b.y - this.y, 2) <= this.size;
	}
}

class Bacteria    
{     
	public int x = 0;
	public int y = 0;
	public double size = 10;
	public int c = 0;

	public static final int range = 7;
	public static final int shift = -3;
	public static final int maxSize = 25;

	public Bacteria(int x, int y, int c)
	{
		this.x = x;
		this.y = y;
		this.c = c;
	}

	void move()
	{
		this.x += (maxSize / this.size) * 0.1 * ((int)(Math.random() * range) + shift) + (this.x < f.x ? 1 : -1);
		this.y += (maxSize / this.size) * 0.1 * ((int)(Math.random() * range) + shift) + (this.y < f.y ? 1 : -1);
	}

	void show()
	{
		fill(c);
		ellipse((float)this.x, (float)this.y, (float)this.size, (float)this.size);
	}
}    