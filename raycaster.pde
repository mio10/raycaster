class Vector
{
	int x, y;

	Vector(int x, int y)
	{
		this.x = x;
		this.y = y;
	}
}

class Obstacle
{
	Vector position;
	color fillColor;

	Obstacle(Vector position)
	{
		this.position = position;
	}

	void display()
	{
		fill(fillColor);
	}
}

class RectangularObstacle extends Obstacle
{
	int width, height;

	RectangularObstacle(Vector position, int width, int height)
	{
		super(position);

		this.width = width;
		this.height = height;
	}

	void display()
	{
		super.display();
		rect(position.x, position.y, width, height);
	}
}

class App
{
	ArrayList<Obstacle> obstacles;

	App()
	{
        setup();
	}

	void setup()
	{
		initObstacles();
	}

    void update()
    {

    }

	void initObstacles()
	{
		obstacles = new ArrayList<Obstacle>();

		RectangularObstacle testRectObstacle = new RectangularObstacle(new Vector(300, 500), 100, 200);
		obstacles.add(testRectObstacle);
	}

    void display()
    {
        displayObstacles();
    }

    void displayObstacles()
    {
        for (int i = 0; i < obstacles.size(); i++) {
            obstacles.get(i).display();
        }
    }
}

final color BACKGROUND_COLOR = color(50, 50, 50);
final color OBSTACLE_COLOR = color(25, 25, 25);

App app;

void setup()
{
	fullScreen();

    app = new App();
}

void draw()
{
	background(BACKGROUND_COLOR);

    app.update();
    app.display();
}