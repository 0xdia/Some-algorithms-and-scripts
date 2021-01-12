#include "pseudorandom_number_generator.cpp"


int main() {
  cout << "insert 5 keys" << endl;
  vector<long long> keys(5);
  for (long long& key: keys)
    cin >> key;

  pseudorandom_number_generator g = pseudorandom_number_generator(keys);

  cout << g.get_random_number() << endl;
  cout << g.get_random_number(150, 22200) << endl;
      
  return 0;
}
