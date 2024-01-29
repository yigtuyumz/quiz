#include <stdio.h>      /* for printf           */
#include <stdlib.h>     /* for exit and malloc  */

/*
 * Returns the length of str.
 */
static size_t
utils_strlen(const char *str)
{
    size_t len = 0;

    while (*(str + len)) {
        len++;
    }

    return (len);
}

/*
 * Returns the maximum value among 2 numbers.
*/
static size_t
utils_getmax(size_t val1, size_t val2)
{
    if (val1 >= val2) {
        return (val1);
    }

    return (val2);
}

/*
 * Returns the minimum value among 2 numbers.
*/
static size_t
utils_getmin(size_t val1, size_t val2)
{
    if (val1 <= val2) {
        return (val1);
    }

    return (val2);
}

/*
 * Compares s1 with s2 char by char.
 * Displays the result of comparison.
 * '!' for every different char
 * '+' for every extra char
 * '-' for every missing char
 * Returns the count of the characters which differs.
 */
static int
compare_inputs(char *s1, char *s2)
{

    int ret_val = 0;
    size_t i = 0;
    size_t len1 = utils_strlen(s1);
    size_t len2 = utils_strlen(s2);
    size_t blen = utils_getmax(len1, len2);
    size_t slen = utils_getmin(len1, len2);
    char *s = (char *) malloc(sizeof(char) * (blen + 1));

    while (i < blen) {
        if (*(s1 + i) == *(s2 + i)) {
            *(s + i) = *(s1 + i);
        } else {
            *(s + i) = '!';
            ret_val++;
        }
        if (i >= slen) {
            if (i >= len1) {
                *(s + i) = '+';
            } else {
                *(s + i) = '-';
            }
        }
        i++;
    }

    printf("%s\n", s);
    free(s);

    return (ret_val);
}

/*
 * Usage of this program.
 * Informs the user when the program is not used properly.
 * Then ends the program immediately with status code 1.
 */
void
program_usage(void)
{
    printf("Please provide at least 2 arguments to run this program!\n");
    printf("  argv1 : value\n");
    printf("  argv2 : user input\n");
    exit(1);
}

int
main(int argc, char *argv[])
{
    if (argc < 3) {
        program_usage();
    }

    return (compare_inputs(argv[1], argv[2]));
}
