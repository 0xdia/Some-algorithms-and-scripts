#include "pseudorandom_generator.cpp"


int main() {
  cout << "insert 5 keys" << endl;
  vector<long long> keys(5);
  for (long long& key: keys)
    cin >> key;

  pseudorandom_generator g = pseudorandom_generator(keys);

  cout << g.get_random_number() << endl;
  cout << g.get_random_number(654651, 6456484) << endl;
      
  return 0;
}
