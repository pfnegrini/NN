// Daniel Shiffman
// The Nature of Code
// http://natureofcode.com

// An animated drawing of a Neural Network

class Neuron {
  // Neuron has a location
  PVector location;

  // Neuron has a list of connections
  ArrayList<Connection> connections;

  // We now track the inputs and sum them
  float sum = 0;
  String activation;

  // The Neuron's size can be animated
  float r = 32;
  int ID;
  float bias=1;
  int Layer;

  Neuron(float x, float y, int ID_, String activation_, int Layer_) {
    location = new PVector(x, y);
    connections = new ArrayList<Connection>();
    ID = ID_;
    activation = activation_;
    Layer = Layer_;
  }

  // Add a Connection
  void addConnection(Connection c) {
    connections.add(c);
  } 

  //Activation functions
 float identity(float x) {

    return x;
  }

  float sigmoid(float x) {
    float y = 1 / (1 + exp(-x));
    return y;
  }

  float tanh(float x) {
    float y = (exp(x)-exp(-x))/(exp(x)+exp(-x));
    return y;
  }

  float step(float x) {
    float y;
    if (x >= 0) {
      y = 1;
    } else {
      y = -1;
    }
    return y;
  }

  // Receive an input
  float activate(float input) {
    float s=0, o=0;
    if (activation == "identity") {
      s = identity(sum);
    } else if (activation == "sigmoid") {
      s = sigmoid(sum);
    } else if (activation == "tanh") {
      s = tanh(sum);
    } else if (activation == "step") {
      s = step(sum);
    }
    return o = s + bias;
  } 
  
  // The Neuron fires
  void fire() {
    r = 64;   // It suddenly is bigger
    println("fired");
    // We send the output through all connections
    for (Connection c : connections) {
      c.feedforward(sum);
    }
  }

  // Draw it as a circle
  void display() {
    stroke(0);
    strokeWeight(1);
    // Brightness is mapped to sum
    float b = map(sum, 0, 1, 255, 0);
    fill(b);
    ellipse(location.x, location.y, r, r);
    text(ID, location.x, location.y+r*1.1);
    // Size shrinks down back to original dimensions
    r = lerp(r, 32, 0.1);
  }
  
  void printConn(){
    String LOG ="N/A";
  for (int j = 0; j < connections.size();j++)
      {
        Connection c = connections.get(j);
         LOG = "CID " + str(c.ID) + " a " + str(c.a.ID) + " b " + str(c.b.ID) + " La: " + str(c.a.Layer) + " Lb: " + str(c.b.Layer);
        println(LOG);
      }
  
  }
}

