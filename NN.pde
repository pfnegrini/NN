// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An animated drawing of a Neural Network

Network network;
 int w = 640, h =640, ID=0, CID = 0;
 
void setup() {
  size(w,h); 
  // Create the Network object
  network = new Network(width/2, height/2);
  String LOG = "N/A";
  int[] NTW = {2, 3, 5, 6, 2}; 
      //Here's how to access the neuron's properties
      {
        network.create(NTW, "none");
      //Neuron n = network.neurons.get(2);
      //println(n.r);
     network.backpropagate();
     //Here's how to access the Connection's properties
     /*for (int i = 0; i< network.connections.size();i++) 
     {
       Connection c = network.connections.get(i);
     
          println(c.weight);
          //println(network.connections.display());
          
    }*/
      //serialn(network.neurons[1].r);
     
      network.printNTW();
      
    }

}

void draw() {
 
}

void pr(){
  background(255);
  // Update and display the Network
  network.update();
  network.display();

  // Every 30 frames feed in an input
  if (frameCount % 30 == 0) {
    float[] input = {random(10,50), random(-5,50), random(-10,10)};
    network.feedforward(input);
  }
  
}