#include <bits/stdc++.h>

using namespace std;

struct pseudorandom_generator {
  public:
    pseudorandom_generator() {}
    pseudorandom_generator(vector<long long>& keys): _keys(keys) {}
    long long get_random_number() {
      construct_matrices();
      int times = 20;
      while (times--) {
        for (int i=1; i<_matrices.size()-1; i++) {
          _matrices[i-1] = add_matrices(_matrices[i], _matrices[i-1]);
          _matrices[i+1] = xor_matrices(_matrices[i], _matrices[i+1]);
          _matrices[i] = transpose(_matrices[i]);
        }
        reverse(_matrices.begin(), _matrices.end());
      }

      vector<vector<long long>> matrix = _matrices[0];
      for (int i=1; i<_matrices.size(); i++) {
        matrix = add_matrices(_matrices[i], matrix);
        matrix = transpose(matrix);
        matrix = xor_matrices(_matrices[i], matrix);
        matrix = transpose(matrix);
      }

      long long answer = 0ll;
      for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++)
          answer = (answer + matrix[i][j]) % M;
      }
      return answer;
    }
    long long get_random_number(long long a, long long b) {
      assert(b > a);
      return (get_random_number() % b + a) % b;
    }
  private:
    vector<vector<long long>> add_matrices(vector<vector<long long>>& a, vector<vector<long long>>& b) {
      vector<vector<long long>> res(4, vector<long long>(4));
      for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++)
          res[i][j] = (a[i][j] + b[i][j]) % M;
      }
      return res;
    }
    
    vector<vector<long long>> transpose(vector<vector<long long>>& a) {
      vector<vector<long long>> res(4, vector<long long>(4));
      for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++)
          res[i][j] = a[j][i];
      }
      return res;
    }

    vector<vector<long long>> xor_matrices(vector<vector<long long>>& a, vector<vector<long long>>& b) {
      vector<vector<long long>> res(4, vector<long long>(4));
      for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++)
          res[i][j] = (a[i][j]^b[i][j]) % M; 
      }
      return res;
    }

    void construct_matrices() {
      srand(time(NULL));
      long long sum = 0ll;
      for (int i=0; i<_keys.size(); i++) {
        sum = (sum + _keys[i]) % M;
        _matrices.push_back(vector<vector<long long>>(4, vector<long long>(4)));
        for (int j=0; j<4; j++) {
          for (int k=0; k<4; k++) {
            _matrices.back()[j][k] = (rand()%X+1 + sum) % M;
          }
        }
      }
    }

    vector<long long> _keys;
    vector<vector<vector<long long>>> _matrices;
    const long long M = 600851475143;
    const long long X = 46744073709551614;
};
