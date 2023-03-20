class Vector
{
    int x, y;

    Vector(int x, int y)
    {
        this.x = x;
        this.y = y;
    }
}

class Line
{
    Vector a, b;

    Line(Vector a, Vector b)
    {
        this.a = a;
        this.b = b;
    }

    boolean intersectsWith(Line other)
    {
        Vector a1 = a;
        Vector a2 = b;
        Vector b1 = other.a;
        Vector b2 = other.b;
        float v1 = (b2.x - b1.x) * (a1.y - b1.y) - (b2.y - b1.y) * (a1.x - b1.x);
        float v2 = (b2.x - b1.x) * (a2.y - b1.y) - (b2.y - b1.y) * (a2.x - b1.x);
        float v3 = (a2.x - a1.x) * (b1.y - a1.y) - (a2.y - a1.y) * (b1.x - a1.x);
        float v4 = (a2.x - a1.x) * (b2.y - a1.y) - (a2.y - a1.y) * (b2.x - a1.x);
        return v1 * v2 < 0 && v3 * v4 < 0;
    }
}

class Obstacle
{
    ArrayList<Line> lines;

    Obstacle()
    {
        lines = new ArrayList<Line>();
    }

    void addLine(Line line)
    {
        lines.add(line);
    }

    void display()
    {
        stroke(OBSTACLE_COLOR);
        fill(OBSTACLE_COLOR);
        beginShape();
        for (int i = 0; i < lines.size(); i++) {
            Line line = lines.get(i);
            vertex(line.a.x, line.a.y);
            vertex(line.b.x, line.b.y);
        }
        endShape();
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

    void initObstacles()
    {
        obstacles = new ArrayList<Obstacle>();

        Obstacle obstacle = new Obstacle();
        obstacle.addLine(new Line(new Vector(300, 500), new Vector(800, 600)));
        obstacle.addLine(new Line(new Vector(800, 600), new Vector(700, 800)));
        obstacle.addLine(new Line(new Vector(700, 800), new Vector(300, 800)));
        obstacle.addLine(new Line(new Vector(300, 800), new Vector(300, 500)));
        obstacles.add(obstacle);

        obstacle = new Obstacle();
        obstacle.addLine(new Line(new Vector(991, 349), new Vector(1188, 243)));
        obstacle.addLine(new Line(new Vector(1188, 243), new Vector(1542, 308)));
        obstacle.addLine(new Line(new Vector(1542, 308), new Vector(1072, 370)));
        obstacle.addLine(new Line(new Vector(1072, 370), new Vector(991, 349)));
        obstacles.add(obstacle);

        obstacle = new Obstacle();
        obstacle.addLine(new Line(new Vector(361, 261), new Vector(739, 289)));
        obstacle.addLine(new Line(new Vector(739, 289), new Vector(748, 91)));
        obstacle.addLine(new Line(new Vector(748, 91), new Vector(380, 110)));
        obstacle.addLine(new Line(new Vector(380, 110), new Vector(361, 261)));
        obstacles.add(obstacle);

        obstacle = new Obstacle();
        obstacle.addLine(new Line(new Vector(935, 651), new Vector(1264, 663)));
        obstacle.addLine(new Line(new Vector(1264, 663), new Vector(1258, 960)));
        obstacle.addLine(new Line(new Vector(1258, 960), new Vector(911, 958)));
        obstacle.addLine(new Line(new Vector(911, 958), new Vector(935, 651)));
        obstacles.add(obstacle);

        obstacle = new Obstacle();
        obstacle.addLine(new Line(new Vector(639, 429), new Vector(1137, 499)));
        obstacle.addLine(new Line(new Vector(1137, 499), new Vector(1130, 563)));
        obstacle.addLine(new Line(new Vector(1130, 563), new Vector(641, 487)));
        obstacle.addLine(new Line(new Vector(641, 487), new Vector(639, 429)));
        obstacles.add(obstacle);
    }

    void display()
    {
        displayLight();
        displayObstacles();
    }

    void displayObstacles()
    {
        for (int i = 0; i < obstacles.size(); i++) {
            obstacles.get(i).display();
        }
    }

    void displayLight()
    {
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                
                Line ray = new Line(new Vector(x, y), new Vector(mouseX, mouseY));
                
                boolean noLight = false;

                for (int i = 0; i < obstacles.size(); i++) {
                    
                    Obstacle obstacle = obstacles.get(i);
                    
                    for (int j = 0; j < obstacle.lines.size(); j++) {
                        Line wall = obstacle.lines.get(j);
                        noLight = ray.intersectsWith(wall);
                        if (noLight) break;
                    }

                    if (noLight) break;                
                }
                
                color lightColor;
                if (noLight) {
                    lightColor = color(BACKGROUND_COLOR);
                } else {
                    float intesivity = 1 - dist(x, y, mouseX, mouseY)/LIGHT_RANGE;
                    lightColor = color(255*intesivity);
                }
                set(x, y, lightColor);

            }
        }
    }
}

final color BACKGROUND_COLOR = color(0);
final color OBSTACLE_COLOR = color(20);
final color LIGHT_COLOR = color(200);
final int LIGHT_RANGE = 500;

App app;

void setup()
{
    fullScreen();

    app = new App();
}

void draw()
{
    background(BACKGROUND_COLOR);

    app.display();
}