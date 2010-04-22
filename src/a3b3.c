#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#define JUDYERROR_SAMPLE 1
#include <Judy.h>

#include <sys/time.h>

//#define HASH_SIZE (1 << 16)  // 2x slow, seems gen n = 4k, 8k
#define HASH_SIZE (1 << 8)  // faster for large (e.g. n >= 8k)
//#define HASH_SIZE 1  // faster for smaller (e.g. n <= 4k)

int main(int argc, char *argv[]) {
  Word_t i, j, *i_cube, *j_cube;
  Word_t index;
  Word_t n = 1000;
  Word_t *p_value;
  Word_t *cubes;
  //Pvoid_t cubes = NULL;
  Pvoid_t j_array[HASH_SIZE] = {NULL};
  int ret;

  if (argc > 1) {
    n = strtoul(argv[1], NULL, 0);
  }

  cubes = (Word_t *)malloc(sizeof(Word_t) * (n + 1));
  for (i = 1; i <= n; i++) {
    // even at 10k array is better (17s vs 20s)
    cubes[i] = i * i * i;
    //JLI(p_value, cubes, i);
    //*p_value = i * i * i;
  }

  for (i = 0; i < HASH_SIZE; i++) {
    j_array[i] = NULL;
  }

  for (i = 1; i <= n; i++) {
    for (j = 1; j <= i; j++) {
      index = cubes[i] + cubes[j];
      //JLG(i_cube, cubes, i);
      //JLG(j_cube, cubes, j);
      //index = *i_cube + *j_cube;
      J1T(ret, j_array[index % HASH_SIZE], index / HASH_SIZE);
      if (ret == 1) {
        printf("%d %d\n", i, j);
      } else {
        J1S(ret, j_array[index % HASH_SIZE], index / HASH_SIZE);
      }
    }
  }

  return 0;
}
