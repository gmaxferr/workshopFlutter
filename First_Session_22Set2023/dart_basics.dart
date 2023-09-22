void main() {
  // Integer
  int age = 30;
  print('Integer: $age'); // Integer: 30
  
  // Double
  double pi = 3.14;
  print('Double: $pi'); // Double: 3.14

  // String
  String name = 'John Doe';
  print('String: $name'); // String: John Doe

  // Boolean
  bool isTrue = true;
  print('Boolean: $isTrue'); // Boolean: true

  // List
  List<int> numbers = [1, 2, 3];
  print('List: $numbers'); // List: [1, 2, 3]

  // Map
  Map<String, String> fruits = {'a': 'Apple', 'b': 'Banana'};
  print('Map: $fruits\n'); // Map: {a: Apple, b: Banana}

  // If-else
  int x = 5;
  if (x > 10) {
    print('x is greater than 10');
  } else {
    print('x is not greater than 10');
  }
  // x is not greater than 10

  
  

  int y = 7;

  print('y ${y % 2 == 0 ? 'is even' : 'is odd'}');
  // y is even 
  
  print('y ${y == 10 ? 'is equal to' 
              : y > 10 ? 'is greated than' 
              : 'is lower than'} 10');
  // y is lower than 10
  
  
  print('');

  for (int i = 0; i < 5; i++) {
    print('Number $i');
  }
  // Number 0
  // Number 1
  // Number 2
  // Number 3
  // Number 4

  print('');

  int i = 0;
  while (i < 5) {
    print('Number $i');
    i++;
  }
  // Number 0
  // Number 1
  // Number 2
  // Number 3
  // Number 4

  print('');
  
  var aList = [5, 6, 7, 8, 9];
  for (var n in aList) {
    print('Value $n');
    i++;
  }
  // Value 5
  // Value 6
  // Value 7
  // Value 8
  // Value 9

  print('');
  
  void greet() {
    print('Hello, World!');
  }

  greet();
  // Hello, World!


  void greetWithName(String name) {
    print('Hello, $name!');
  }

  greetWithName('John');
  // Hello, John!
  

  void addNumbers(int a, int b) => print('Sum: ${a + b}');
  addNumbers(5, 3);
  // Sum: 8
}
