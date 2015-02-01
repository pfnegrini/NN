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
          println(ID);network.addNeuron(n);
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
    Connection c = new Connection(a, b, weight, ID, 'true');
    a.addConnection(c);
    // Also add the Connection here
    connections.add(c);
  } 
  
  // Sending an input to the first Neuron
  // We should do something better to track multiple inputs
  void feedforward(float[] input) {
    for (int i = 0; i < input.length; i++){
    
      Neuron n = neurons.get(i);
      //n.ativate(input[i]);
    
    }
        
  }
  
  //NOT SURE ABOUT THIS...
 float ffd(float[] input){
   //println("FFD");
   String LOG = "N/A"; 
   //float[] R = new float[NTW[NTW.length-1]]; 
   float R = 0;
   int currentLayer=0;
   //First initialize the NN with the input values 
    for (int i = 0; i < input.length; i++){
      Neuron n = neurons.get(i);
      n.sum = n.activate(n.sum + input[i]);
    } 
    
    for (int i = 0; i< connections.size();i++) 
     {
       Connection c = connections.get(i);
       
       c.b.sum = c.b.sum + c.a.sum * c.weight;
       LOG = "a: " + str(c.a.ID) + " b: " + str(c.b.ID) + " a sum: " + str(c.a.sum) + " weight " + str(c.weight) + " b sum:  " + str(c.b.sum);
       //println(LOG);
       
       //If layer is over need to activate nodes
       if (currentLayer + 1 == c.b.Layer ){
         LOG = "Last conn " + str(c.b.Layer) + " " +str(c.b.ID);
         println(LOG);
         currentLayer ++;
       }
    
    }
    
    //Sum the output nodes. Problem with the number of neurons
 /*   for (int i =  NTW[NTW.length-1]-1; i>0 ;i--) 
     {
      R[i] = neurons.get(neurons.size()-1 - i).sum;
      println(neurons.size()-1-i);
      println(R[i]);
     }
   */  

     R = neurons.get(neurons.size()-1).sum;
    for (int i = 0; i< neurons.size();i++) 
     {
       Neuron n = neurons.get(i);
       n.sum = 0;
     } 
     return R;
 }
    
   //Objective function: steepest descent method 
   float J(float desired, float actual){
     float[] Descent = new float[NTW[NTW.length-1]];
     float res=0;
     /*for (int i = 0; i < NTW[NTW.length-1]; i++){
       res = res + 0.5 * (desired[i] - actual[i]);
     }*/
   //return res = 0.5 * (desired - actual);
   return res = actual * (1 - actual) * (desired - actual);
   }
   
   
        // Backpropagation to adjust weights
  void backpropagate(float desired, float actual) {
    String LOG = "N/A"; 
    //println("Backpropagation");
    //Need to do: for every node => for every connected node => adjust weight 
    //Here's how to access the Connection's properties
      //output layer
      //connections.get(connections.size()-1).weight = J(desired, actual); 
    for (int i = neurons.size()-1; i >= 0; i--) 
     {
      Neuron n = neurons.get(i);
      
      for (int j = 0; j < n.connections.size();j++)
      {    
        n.connections.get(j).weight = n.connections.get(j).weight + n.connections.get(j).a.sum * J(desired, actual); 
        //LOG = "n: " + str(i) + " c: " + str(n.connections.get(j).ID) + " w: " + str(n.connections.get(j).weight) + " J:" + J(desired, actual);
        //text(n.connections.get(j).weight, n.connections.get(j).b.location.x+50, n.connections.get(j).b.location.y);
        //println(LOG);
      }
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
        LOG = "ID " + str(n.ID) + " L: " + str(n.Layer) + ' ' + n.activation + ' ';
        println(LOG);
        n.printConn();
     }
      for (int j = 0; j < connections.size();j++)
      {
        Connection c = connections.get(j);
        LOG = "ID " + str(c.ID) + " La: " + str(c.a.Layer) + " Lb: " + str(c.b.Layer);
        //println(LOG);
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
