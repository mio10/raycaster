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

    Vector intersectionPoint(Vector a, Vector b, Vector c, Vector d)
    {
        float a1 = b.y - a.y;
        float b1 = a.x - b.x;
        float c1 = a1*a.x + b1*a.y;

        float a2 = d.y - c.y;
        float b2 = c.x - d.x;
        float c2 = a2*c.x + b2*c.y;

        float det = a1*b2 - a2*b1;

        if (det == 0) {
            return new Vector(Integer.MAX_VALUE, Integer.MAX_VALUE);
        } else {
            int x = round((b2*c1 - b1*c2)/determinant);
            int y = round((a1*c2 - a2*c1)/determinant);
            return new Vector(x, y);
        }
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