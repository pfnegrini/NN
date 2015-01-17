// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An animated drawing of a Neural Network

Network network;
 int w = 640, h =640, ID=0, CID = 0;
 int[] NTW = {2, 3, 2}; 
 float[] Error = new float[NTW[NTW.length-1]-1]; 
 float[] reference = {0, 0};
 
void setup() {
  size(w,h); 
  // Create the Network object
  network = new Network(width/2, height/2);
  String LOG = "N/A";
      //Here's how to access the neuron's properties
      {
      network.create(NTW, "none");
      network.printNTW();
      //float[] input = {random(10,50), random(-5,50), random(-10,10)};
      //println(network.ffd(input));   
      //network.backpropagate(reference, network.ffd(input));
      
      
      //Neuron n = network.neurons.get(2);
      //println(n.r);
     //Here's how to access the Connection's properties
     /*for (int i = 0; i< network.connections.size();i++) 
     {
       Connection c = network.connections.get(i);
     
          println(c.weight);
          //println(network.connections.display());
          
    }*/
      //serialn(network.neurons[1].r);
     
        
       
    }

for(int i = 0; i<= 10; i++){
  float[] input = {random(0,10), random(0,100)};
  network.backpropagate(target(input), network.ffd(input));
}
float[] input = {2, 1};
  
print("Result (2,1): ");println(network.ffd(input));

}


float target(float[] x){
  float y = 0;
  y = x[0]*x[0]+x[1];
  return y;
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
