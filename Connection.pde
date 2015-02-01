// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An animated drawing of a Neural Network

class Connection {
  // Connection is from Neuron A to B
  Neuron a;
  Neuron b;
  
  // Connection has a weight
  float weight;
  int ID;
  // Variables to track the animation
  boolean sending = false;
  boolean last = false;
  PVector sender;
  
  // Need to store the output for when its time to pass along
  float output = 0;

  Connection(Neuron from, Neuron to, float w, int ID_, boolean last_) {
    weight = w;
    a = from;
    b = to;
    ID = ID_;
    last = last_;
  }
  
  // The Connection is active
  void feedforward(float val) {
    output = val*weight;        // Compute output
    sender = a.location.get();  // Start animation at Neuron A
    sending = true;             // Turn on sending
    println(output);
  }
  
  // Update traveling sender
  void update() {
    if (sending) {
      // Use a simple interpolation
      sender.x = lerp(sender.x, b.location.x, 0.1);
      sender.y = lerp(sender.y, b.location.y, 0.1);
      float d = PVector.dist(sender, b.location);
      // If we've reached the end
      if (d < 1) {
        // Pass along the output!
        b.activate(output);
        sending = false;
      }
    }
  }
  
  // Draw line and traveling circle
  void display() {
    stroke(0);
    strokeWeight(1+weight*4);
    line(a.location.x, a.location.y, b.location.x, b.location.y);
    //text(ID, a.location.x+15, a.location.y+15);
    if (sending) {
      fill(0);
      strokeWeight(1);
      ellipse(sender.x, sender.y, 16, 16);
    }
  }
}

