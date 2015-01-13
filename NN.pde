// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An animated drawing of a Neural Network

Network network;

void setup() {
  int w = 640, h =640, ID=0, CID = 0;
  size(w,h); 
  // Create the Network object
  network = new Network(width/2, height/2);
  int[] NTW={3,8,1};
  
  int layers = NTW.length-1;
  int inputs = NTW[0];
  int outputs = NTW[NTW.length-1];
  String LOG = "N/A";
  Neuron output = new Neuron(250, 0, 999, "identity");
 
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
        //Verify this,  does not always work
        for (int k = 0; k < inputs; k++) {
          Neuron prev = network.neurons.get(network.neurons.size()-inputs+k-j); 
          network.connect(prev, n, random(1), CID);
          CID++;
        }
      }
      if (i == layers-1) {
        network.connect(n, output, random(1), CID);
        CID++;
      }
      network.addNeuron(n);
    }
  }
  } 
  network.addNeuron(output);
      //Here's how to access the neuron's properties
      {
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

