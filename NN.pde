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
      network.display();
      
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
     
        float[] input = {random(-10,10), random(-10,100)};
  //network.backpropagate(target(input), network.ffd(input));
   network.ffd((input));
       
    }

for(int i = 0; i<= 10000; i++){
  //float[] input = {random(-10,10), random(-10,100)};
  //network.backpropagate(target(input), network.ffd(input));
  //network.ffd((input));
}

println("Trainig");
float[] input = {8.5, 9.5};
LOG = "input: " + str(input[0]) + " " + str(input[1]) + " target: " + str(target(input)) + " NN: " + str(network.ffd(input));
println(LOG);
println("--------------------------");


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
    float[] input = {random(0,1), random(-1,1), random(-1,1)};
    network.feedforward(input);
  }
  
}
