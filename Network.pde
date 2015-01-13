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


    void create(int[] NTW, String type){
    int layers = NTW.length;
    int inputs = NTW[0];
    int outputs = NTW[NTW.length-1];
    
 
    for (int i = 0; i < layers; i++) {
       {
        for (int j = 0; j < NTW[i]; j++) {
          float x = map(i, 0, layers, -w/2+50, w/2);
          float y = map(j, 0, max(NTW), -h/2+25, h/2-25);
          String ACT;
          if (i == 0) {
            ACT = "identity";
          }
          else {
            ACT = "sigmoid";      
          }
          
          Neuron n = new Neuron(x, y, ID, ACT);
          ID++;
          network.display();
          if (i > 0) {
            //Each neuron is connected to all the ones in the previous layer
            for (int k = 0; k < NTW[i-1]; k++) {
              Neuron prev = network.neurons.get(network.neurons.size()-NTW[i-1]+k-j); 
              network.connect(prev, n, random(1), CID);
              CID++;
            }
          }
          network.addNeuron(n);
        }
      }
    } 
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
  
 void ffd(float[] input){
   String LOG = "N/A"; 
    
   //First initialize the NN with the input values 
    for (int i = 0; i < input.length; i++){
      Neuron n = neurons.get(i);
      n.sum = n.sum + input[i];
    }
    
    for (int i = 0; i< network.connections.size();i++) 
     {
       Connection c = network.connections.get(i);
       c.b.sum = c.b.sum + c.a.sum * c.weight;
       LOG = "a: " + str(c.a.ID) + " b: " + str(c.b.ID) + " " + str(c.b.sum);
       println(LOG);
    }
 }
  
  
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
