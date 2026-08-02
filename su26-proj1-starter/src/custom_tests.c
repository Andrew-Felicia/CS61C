#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "asserts.h"
// Necessary due to static functions in game.c
#include "game.c"

/* Look at asserts.c for some helpful assert functions */

int greater_than_forty_two(int x) { return x > 42; }

bool is_vowel(char c) {
  char *vowels = "aeiouAEIOU";
  for (int i = 0; i < strlen(vowels); i++) {
    if (c == vowels[i]) {
      return true;
    }
  }
  return false;
}

/*
  Example 1: Returns true if all test cases pass. False otherwise.
    The function greater_than_forty_two(int x) will return true if x > 42. False otherwise.
    Note: This test is NOT comprehensive
*/
bool test_greater_than_forty_two() {
  int testcase_1 = 42;
  bool output_1 = greater_than_forty_two(testcase_1);
  if (!assert_false("output_1", output_1)) {
    return false;
  }

  int testcase_2 = -42;
  bool output_2 = greater_than_forty_two(testcase_2);
  if (!assert_false("output_2", output_2)) {
    return false;
  }

  int testcase_3 = 4242;
  bool output_3 = greater_than_forty_two(testcase_3);
  if (!assert_true("output_3", output_3)) {
    return false;
  }

  return true;
}

/*
  Example 2: Returns true if all test cases pass. False otherwise.
    The function is_vowel(char c) will return true if c is a vowel (i.e. c is a,e,i,o,u)
    and returns false otherwise
    Note: This test is NOT comprehensive
*/
bool test_is_vowel() {
  char testcase_1 = 'a';
  bool output_1 = is_vowel(testcase_1);
  if (!assert_true("output_1", output_1)) {
    return false;
  }

  char testcase_2 = 'e';
  bool output_2 = is_vowel(testcase_2);
  if (!assert_true("output_2", output_2)) {
    return false;
  }

  char testcase_3 = 'i';
  bool output_3 = is_vowel(testcase_3);
  if (!assert_true("output_3", output_3)) {
    return false;
  }

  char testcase_4 = 'o';
  bool output_4 = is_vowel(testcase_4);
  if (!assert_true("output_4", output_4)) {
    return false;
  }

  char testcase_5 = 'u';
  bool output_5 = is_vowel(testcase_5);
  if (!assert_true("output_5", output_5)) {
    return false;
  }

  char testcase_6 = 'k';
  bool output_6 = is_vowel(testcase_6);
  if (!assert_false("output_6", output_6)) {
    return false;
  }

  return true;
}

/* Task 4.1 */

bool test_is_tail() {
  char testcase_1 = 'w';
  char testcase_2 = 's';
  char testcase_3 = 'a';
  char testcase_4 = 'd';
  char testcase_5 = 'm';
  char testcase_6 = '\0';

  bool output_1 = is_tail(testcase_1);
  bool output_2 = is_tail(testcase_2);
  bool output_3 = is_tail(testcase_3);
  bool output_4 = is_tail(testcase_4);
  bool output_5 = is_tail(testcase_5);
  bool output_6 = is_tail(testcase_6);

  if (!assert_true("output_1", output_1)) {
    return false;
  }
  if (!assert_true("output_2", output_2)) {
    return false;
  }
  if (!assert_true("output_3", output_3)) {
    return false;
  }
  if (!assert_true("output_4", output_4)) {
    return false;
  }
  if (!assert_false("output_5", output_5)) {
    return false;
  }
  if (!assert_false("output_6", output_6)) {
    return false;
  }

  
  return true;
}

bool test_is_head() {
  const char valid_cases[] = {
      'W', 'A', 'S', 'D', 'x'
  };

  const char invalid_cases[] = {
      'w', 'a', 's', 'd',   // Tails, not heads
      '^', '<', 'v', '>',   // Body characters
      'X',                  // Only lowercase x is valid
      'm', '0', ' ', '#', '*',
      '\n', '\0'
  };

  char test_name[64];

  for (size_t i = 0; i < sizeof(valid_cases); i++) {
    char input = valid_cases[i];
    bool output = is_head(input);

    snprintf(test_name, sizeof(test_name),
             "is_head valid case %zu: '%c'", i, input);

    if (!assert_true(test_name, output)) {
      return false;
    }
  }

  for (size_t i = 0; i < sizeof(invalid_cases); i++) {
    char input = invalid_cases[i];
    bool output = is_head(input);

    snprintf(test_name, sizeof(test_name),
             "is_head invalid case %zu", i);

    if (!assert_false(test_name, output)) {
      return false;
    }
  }

  return true;
}

bool test_is_snake() {
  const char valid_cases[] = {
      // Tail
      'w', 'a', 's', 'd',

      // Body
      '^', '<', 'v', '>',

      // Head
      'W', 'A', 'S', 'D',

      // Dead head
      'x'
  };

  const char invalid_cases[] = {
      'X',
      'm', 'z',
      '0', '9',
      ' ', '\t', '\n',
      '#', '*', '+', '-',
      '\0'
  };

  char test_name[64];

  for (size_t i = 0; i < sizeof(valid_cases); i++) {
    char input = valid_cases[i];
    bool output = is_snake(input);

    snprintf(test_name, sizeof(test_name),
             "is_snake valid case %zu: '%c'", i, input);

    if (!assert_true(test_name, output)) {
      return false;
    }
  }

  for (size_t i = 0; i < sizeof(invalid_cases); i++) {
    char input = invalid_cases[i];
    bool output = is_snake(input);

    snprintf(test_name, sizeof(test_name),
             "is_snake invalid case %zu", i);

    if (!assert_false(test_name, output)) {
      return false;
    }
  }

  return true;
}

bool test_body_to_tail() {
  char testcase_1 = '^';
  char testcase_2 = '<';
  char testcase_3 = 'v';
  char testcase_4 = '>';

  char output_1 = body_to_tail(testcase_1);
  char output_2 = body_to_tail(testcase_2);
  char output_3 = body_to_tail(testcase_3);
  char output_4 = body_to_tail(testcase_4);

  if (output_1 != 'w') {
    printf("body_to_tail('^'): expected 'w', got '%c'\n", output_1);
    return false;
  }

  if (output_2 != 'a') {
    printf("body_to_tail('<'): expected 'a', got '%c'\n", output_2);
    return false;
  }

  if (output_3 != 's') {
    printf("body_to_tail('v'): expected 's', got '%c'\n", output_3);
    return false;
  }

  if (output_4 != 'd') {
    printf("body_to_tail('>'): expected 'd', got '%c'\n", output_4);
    return false;
  }

  return true;
}

bool test_head_to_body() {
  char testcase_1 = 'W';
  char testcase_2 = 'A';
  char testcase_3 = 'S';
  char testcase_4 = 'D';

  char output_1 = head_to_body(testcase_1);
  char output_2 = head_to_body(testcase_2);
  char output_3 = head_to_body(testcase_3);
  char output_4 = head_to_body(testcase_4);

  if (output_1 != '^') {
    printf("head_to_body('W'): expected '^', got '%c'\n", output_1);
    return false;
  }

  if (output_2 != '<') {
    printf("head_to_body('A'): expected '<', got '%c'\n", output_2);
    return false;
  }

  if (output_3 != 'v') {
    printf("head_to_body('S'): expected 'v', got '%c'\n", output_3);
    return false;
  }

  if (output_4 != '>') {
    printf("head_to_body('D'): expected '>', got '%c'\n", output_4);
    return false;
  }

  return true;
}


#include <stdbool.h>
#include <limits.h>
#include <stdio.h>

bool test_get_next_row() {
  /* Move down: v, s, S */
  if (get_next_row(5, 'v') != 6) {
    printf("get_next_row(5, 'v'): expected 6\n");
    return false;
  }

  if (get_next_row(5, 's') != 6) {
    printf("get_next_row(5, 's'): expected 6\n");
    return false;
  }

  if (get_next_row(5, 'S') != 6) {
    printf("get_next_row(5, 'S'): expected 6\n");
    return false;
  }

  /* Move up: ^, w, W */
  if (get_next_row(5, '^') != 4) {
    printf("get_next_row(5, '^'): expected 4\n");
    return false;
  }

  if (get_next_row(5, 'w') != 4) {
    printf("get_next_row(5, 'w'): expected 4\n");
    return false;
  }

  if (get_next_row(5, 'W') != 4) {
    printf("get_next_row(5, 'W'): expected 4\n");
    return false;
  }

  /* Horizontal direction characters should not change the row */
  if (get_next_row(5, '>') != 5) {
    printf("get_next_row(5, '>'): expected 5\n");
    return false;
  }

  if (get_next_row(5, '<') != 5) {
    printf("get_next_row(5, '<'): expected 5\n");
    return false;
  }

  if (get_next_row(5, 'a') != 5) {
    printf("get_next_row(5, 'a'): expected 5\n");
    return false;
  }

  if (get_next_row(5, 'd') != 5) {
    printf("get_next_row(5, 'd'): expected 5\n");
    return false;
  }

  if (get_next_row(5, 'A') != 5) {
    printf("get_next_row(5, 'A'): expected 5\n");
    return false;
  }

  if (get_next_row(5, 'D') != 5) {
    printf("get_next_row(5, 'D'): expected 5\n");
    return false;
  }

  /* Unrelated characters should not change the row */
  if (get_next_row(5, 'x') != 5) {
    printf("get_next_row(5, 'x'): expected 5\n");
    return false;
  }

  if (get_next_row(5, '*') != 5) {
    printf("get_next_row(5, '*'): expected 5\n");
    return false;
  }

  if (get_next_row(5, ' ') != 5) {
    printf("get_next_row(5, ' '): expected 5\n");
    return false;
  }

  if (get_next_row(5, '\0') != 5) {
    printf("get_next_row(5, '\\0'): expected 5\n");
    return false;
  }

  /* Boundary cases */
  if (get_next_row(0, 'v') != 1) {
    printf("get_next_row(0, 'v'): expected 1\n");
    return false;
  }

  /*
   * Because cur_row is unsigned, 0 - 1 wraps around to UINT_MAX.
   */
  if (get_next_row(0, '^') != UINT_MAX) {
    printf("get_next_row(0, '^'): expected UINT_MAX\n");
    return false;
  }

  return true;
}

bool test_get_next_col() {
  /* Move right: >, d, D */
  if (get_next_col(5, '>') != 6) {
    printf("get_next_col(5, '>'): expected 6\n");
    return false;
  }

  if (get_next_col(5, 'd') != 6) {
    printf("get_next_col(5, 'd'): expected 6\n");
    return false;
  }

  if (get_next_col(5, 'D') != 6) {
    printf("get_next_col(5, 'D'): expected 6\n");
    return false;
  }

  /* Move left: <, a, A */
  if (get_next_col(5, '<') != 4) {
    printf("get_next_col(5, '<'): expected 4\n");
    return false;
  }

  if (get_next_col(5, 'a') != 4) {
    printf("get_next_col(5, 'a'): expected 4\n");
    return false;
  }

  if (get_next_col(5, 'A') != 4) {
    printf("get_next_col(5, 'A'): expected 4\n");
    return false;
  }

  /* Vertical direction characters should not change the column */
  if (get_next_col(5, '^') != 5) {
    printf("get_next_col(5, '^'): expected 5\n");
    return false;
  }

  if (get_next_col(5, 'v') != 5) {
    printf("get_next_col(5, 'v'): expected 5\n");
    return false;
  }

  if (get_next_col(5, 'w') != 5) {
    printf("get_next_col(5, 'w'): expected 5\n");
    return false;
  }

  if (get_next_col(5, 's') != 5) {
    printf("get_next_col(5, 's'): expected 5\n");
    return false;
  }

  if (get_next_col(5, 'W') != 5) {
    printf("get_next_col(5, 'W'): expected 5\n");
    return false;
  }

  if (get_next_col(5, 'S') != 5) {
    printf("get_next_col(5, 'S'): expected 5\n");
    return false;
  }

  /* Unrelated characters should not change the column */
  if (get_next_col(5, 'x') != 5) {
    printf("get_next_col(5, 'x'): expected 5\n");
    return false;
  }

  if (get_next_col(5, '#') != 5) {
    printf("get_next_col(5, '#'): expected 5\n");
    return false;
  }

  if (get_next_col(5, ' ') != 5) {
    printf("get_next_col(5, ' '): expected 5\n");
    return false;
  }

  if (get_next_col(5, '\0') != 5) {
    printf("get_next_col(5, '\\0'): expected 5\n");
    return false;
  }

  /* Boundary cases */
  if (get_next_col(0, '>') != 1) {
    printf("get_next_col(0, '>'): expected 1\n");
    return false;
  }

  /*
   * Because cur_col is unsigned, 0 - 1 wraps around to UINT_MAX.
   */
  if (get_next_col(0, '<') != UINT_MAX) {
    printf("get_next_col(0, '<'): expected UINT_MAX\n");
    return false;
  }

  return true;
}

bool test_customs() {
  if (!test_greater_than_forty_two()) {
    printf("%s\n", "test_greater_than_forty_two failed.");
    return false;
  }
  if (!test_is_vowel()) {
    printf("%s\n", "test_is_vowel failed.");
    return false;
  }
  if (!test_is_tail()) {
    printf("%s\n", "test_is_tail failed");
    return false;
  }
  if (!test_is_head()) {
    printf("%s\n", "test_is_head failed");
    return false;
  }
  if (!test_is_snake()) {
    printf("%s\n", "test_is_snake failed");
    return false;
  }
  if (!test_body_to_tail()) {
    printf("%s\n", "test_body_to_tail failed");
    return false;
  }
  if (!test_head_to_body()) {
    printf("%s\n", "test_head_to_body failed");
    return false;
  }
  if (!test_get_next_row()) {
    printf("%s\n", "test_get_next_row failed");
    return false;
  }
  if (!test_get_next_col()) {
    printf("%s\n", "test_get_next_col failed");
    return false;
  }
  return true;
}

int main(int argc, char *argv[]) {
  init_colors();

  if (!test_and_print("custom", test_customs)) {
    return 0;
  }

  return 0;
}
