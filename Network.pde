// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An animated drawing of a Neural Network

class Network {
  
  // The Network has a list of neurons
  ArrayList<Neuron> neurons;
  
  // The Network now keeps a duplicate list of all Connection objects.
  // This makes it easier to draw everything in this class
  ArrayList<Connection> connections;
  PVector location;

  Network(float x, float y) {
    location = new PVector(x, y);
    neurons = new ArrayList<Neuron>();
    connections = new ArrayList<Connection>();
  }

  // We can add a Neuron
  void addNeuron(Neuron n) {
    neurons.add(n);
  }

  // We can connection two Neurons
  void connect(Neuron a, Neuron b, float weight, int ID) {
    Connection c = new Connection(a, b, weight, ID);
    a.addConnection(c);
    // Also add the Connection here
    connections.add(c);
  } 
  
  // Sending an input to the first Neuron
  // We should do something better to track multiple inputs
  void feedforward(float[] input) {
    for (int i = 0; i < input.length; i++){
    
      Neuron n = neurons.get(i);
      n.feedforward(input[i]);
    
    }
        
  }
  
  // Backpropagation to adjust weights
  void backpropagate() {
    //Need to do: for every node => for every connected node => adjust weight 
    //Here's how to access the Connection's properties
     for (int i = 0; i< connections.size();i++) 
     {
       Connection c = connections.get(i);
     
          print(c.weight);print(" ");println(c.ID);
          //println(network.connections.display());
          
    }
 
    
  }
  
  // Update the animation
  void update() {
    for (Connection c : connections) {
      c.update();
    }
  }
  
  void printNTW() {
    String LOG = "N/A"; 
    for (int i = 0; i < neurons.size();i++) 
     {
      Neuron n = neurons.get(i);
      for (int j = 0; j < n.connections.size();j++)
      {
        LOG = str(i) + ' ' + n.activation + ' ' + str(n.connections.get(j).b.ID) + ' ' + str(n.connections.get(j).ID) + ' ' + str(n.connections.get(j).weight);
        println(LOG);
       }
     } 
  }
  // Draw everything
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    for (Neuron n : neurons) {
      n.display();
    }

    for (Connection c : connections) {
      c.display();
    }
    popMatrix();
  }
}

