// Getters and Setters: WRONG!
Dog dog = new Dog();
dog.setWeight("23kg");
w = dog.getWeight();

// Smart objects: RIGHT!
Dog dog = new Dog("23kg");
int w = dog.weight();