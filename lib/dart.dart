void main() {
  Honda honda = Honda();
  Tesla tesla = Tesla();
  honda.petrolBased("Honda");
  tesla.electricBased();
  tesla.petrolBased("Tesla");
}

mixin PetrolVariant {
  void petrolBased(String carName) {
    print("$carName Petrol Based Car");
  }
}
mixin ElectricVariant {
  void electricBased() {
    print("Electric Based Car");
  }
}

class Honda with PetrolVariant {}

class Tesla with PetrolVariant, ElectricVariant {}
