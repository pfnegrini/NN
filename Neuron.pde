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

  Neuron(float x, float y, int ID_, String activation_) {
    location = new PVector(x, y);
    connections = new ArrayList<Connection>();
    ID = ID_;
    activation = activation_;
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
  void feedforward(float input) {
    // Accumulate it
    sum += input;
    // Activate it?
    float s=0;
    if (activation == "identity") {
      s = identity(sum);
    } else if (activation == "sigmoid") {
      s = sigmoid(sum);
    } else if (activation == "tanh") {
      s = tanh(sum);
    } else if (activation == "step") {
      s = step(sum);
    }
    sum= s + bias;
    if (sum > 1)
    { 
      //println((sum));  
      fire();
      sum = 0;  // Reset the sum to 0 if it fires
    }
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
}
