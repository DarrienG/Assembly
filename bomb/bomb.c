//
// This file was generated by the Retargetable Decompiler
// Website: https://retdec.com
// Copyright (c) 2015 Retargetable Decompiler <info@retdec.com>
//

#include <ctype.h>
#include <netdb.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

// ------------------------ Structures ------------------------

struct _IO_FILE {
    struct _IO_FILE * e0;
    int32_t e1;
    int32_t e2;
    int32_t e3;
    int16_t e4;
    char e5;
    char e6[1];
    char * e7;
    int64_t e8;
    char * e9;
    char * e10;
    char * e11;
    char * e12;
    int32_t e13;
    int32_t e14;
    char e15[40];
};

struct sockaddr {
    int16_t e0;
    char e1[14];
};

struct struct_1 {
    int32_t e0;
    int32_t e1;
    int32_t e2;
};

struct struct_2 {
    char e0;
    char e1[2];
};

struct struct__IO_FILE {
    int32_t e0;
    char * e1;
    char * e2;
    char * e3;
    char * e4;
    char * e5;
    char * e6;
    char * e7;
    char * e8;
    char * e9;
    char * e10;
    char * e11;
    struct struct__IO_marker * e12;
    struct struct__IO_FILE * e13;
    int32_t e14;
    int32_t e15;
    int32_t e16;
    int16_t e17;
    char e18;
    char e19[1];
    char * e20;
    int64_t e21;
    char * e22;
    char * e23;
    char * e24;
    char * e25;
    int32_t e26;
    int32_t e27;
    char e28[40];
};

struct struct__IO_marker {
    struct struct__IO_marker * e0;
    struct struct__IO_FILE * e1;
    int32_t e2;
};

// ------------------- Function Prototypes --------------------

void blank_line(void);
void explode_bomb(void);
void fun6(void);
void fun7(void);
void func4(void);
void initialize_bomb(void);
void open_clientfd(void);
void phase_1(void);
void phase_2(void);
void phase_3(void);
void phase_4(void);
void phase_5(void);
void phase_6(void);
void phase_defused(void);
void read_line(void);
void read_six_numbers(void);
void secret_phase(void);
void send_msg(void);
int32_t sig_handler(int32_t a1);
void skip(void);
void string_length(void);
void strings_not_equal(void);

// --------------------- Global Variables ---------------------

int32_t g1 = 0; // eax
int32_t g2 = 0; // ebx
int32_t g3 = 0; // edi
int32_t g4 = 0; // esi
int32_t g5 = 19; // 0x804a1a0
char * g6[2] = {
    "mercury.cs.uml.edu",
    "mercury"
}; // 0x804a6e0
int32_t g7 = 0; // 0x804a820
int32_t g8 = 0; // 0x804a840
int32_t g9 = 0; // 0x804a84c
struct _IO_FILE * infile; // 0x804a850

// ------------------------ Functions -------------------------

// From module:   /usr/cs/fac1/bomb/bomblab/src/bomb.c
// Address range: 0x80489f4 - 0x8048b4f
// Line range:    36 - 114
int main(int argc, char ** argv) {
    int32_t v1 = (int32_t)argv; // 0x8048a02_1
    g4 = v1;
    int32_t puts_rc6; // 0x8048b29
    int32_t puts_rc; // 0x8048a93
    int32_t puts_rc2; // 0x8048ab1
    int32_t puts_rc3; // 0x8048acf
    int32_t puts_rc4; // 0x8048aed
    int32_t puts_rc5; // 0x8048b0b
    int32_t file_path;
    if ((char *)argc == (char *)1) {
        // 0x8048a0a
        infile = (struct _IO_FILE *)g7;
        // branch -> 0x8048a7b
        // 0x8048a7b
        initialize_bomb();
        file_path = (int32_t)"Welcome to my fiendish little bomb. You have 6 phases with";
        puts("Welcome to my fiendish little bomb. You have 6 phases with");
        file_path = (int32_t)"which to blow yourself up. Have a nice day!";
        puts_rc = puts("which to blow yourself up. Have a nice day!");
        read_line();
        file_path = puts_rc;
        phase_1();
        phase_defused();
        file_path = (int32_t)"Phase 1 defused. How about the next one?";
        puts_rc2 = puts("Phase 1 defused. How about the next one?");
        read_line();
        file_path = puts_rc2;
        phase_2();
        phase_defused();
        file_path = (int32_t)"That's number 2.  Keep going!";
        puts_rc3 = puts("That's number 2.  Keep going!");
        read_line();
        file_path = puts_rc3;
        phase_3();
        phase_defused();
        file_path = (int32_t)"Halfway there!";
        puts_rc4 = puts("Halfway there!");
        read_line();
        file_path = puts_rc4;
        phase_4();
        phase_defused();
        file_path = (int32_t)"So you got that one.  Try this one.";
        puts_rc5 = puts("So you got that one.  Try this one.");
        read_line();
        file_path = puts_rc5;
        phase_5();
        phase_defused();
        file_path = (int32_t)"Good work!  On to the next...";
        puts_rc6 = puts("Good work!  On to the next...");
        read_line();
        file_path = puts_rc6;
        phase_6();
        phase_defused();
        return 0;
    }
    // 0x8048a16
    int32_t v2;
    if (argc != 2) {
        // 0x8048a5d
        v2 = *(int32_t *)argv;
        file_path = (int32_t)"Usage: %s [<input_file>]\n";
        printf("Usage: %s [<input_file>]\n", &v2);
        file_path = 8;
        exit(8);
        // UNREACHABLE
    }
    int32_t v3 = v1 + 4; // 0x8048a1b
    g2 = v3;
    v2 = (int32_t)"r";
    file_path = *(int32_t *)v3;
    struct struct__IO_FILE * file = fopen((char *)&file_path, "r"); // 0x8048a2b
    infile = (struct _IO_FILE *)file;
    if (file == NULL) {
        int32_t v4 = *(int32_t *)g2;
        v2 = *(int32_t *)g4;
        file_path = (int32_t)"%s: Error: Couldn't open %s\n";
        printf("%s: Error: Couldn't open %s\n", &v2, &v4);
        file_path = 8;
        exit(8);
        // UNREACHABLE
    }
    // 0x8048a7b
    initialize_bomb();
    file_path = (int32_t)"Welcome to my fiendish little bomb. You have 6 phases with";
    puts("Welcome to my fiendish little bomb. You have 6 phases with");
    file_path = (int32_t)"which to blow yourself up. Have a nice day!";
    puts_rc = puts("which to blow yourself up. Have a nice day!");
    read_line();
    file_path = puts_rc;
    phase_1();
    phase_defused();
    file_path = (int32_t)"Phase 1 defused. How about the next one?";
    puts_rc2 = puts("Phase 1 defused. How about the next one?");
    read_line();
    file_path = puts_rc2;
    phase_2();
    phase_defused();
    file_path = (int32_t)"That's number 2.  Keep going!";
    puts_rc3 = puts("That's number 2.  Keep going!");
    read_line();
    file_path = puts_rc3;
    phase_3();
    phase_defused();
    file_path = (int32_t)"Halfway there!";
    puts_rc4 = puts("Halfway there!");
    read_line();
    file_path = puts_rc4;
    phase_4();
    phase_defused();
    file_path = (int32_t)"So you got that one.  Try this one.";
    puts_rc5 = puts("So you got that one.  Try this one.");
    read_line();
    file_path = puts_rc5;
    phase_5();
    phase_defused();
    file_path = (int32_t)"Good work!  On to the next...";
    puts_rc6 = puts("Good work!  On to the next...");
    read_line();
    file_path = puts_rc6;
    phase_6();
    phase_defused();
    return 0;
}

// Address range: 0x8048b50 - 0x8048b79
void func4(void) {
    // 0x8048b50
    g1 = 1;
    uint32_t v1;
    if (v1 >= 1) {
        // 0x8048b62
        func4();
        g1 *= 7;
        // branch -> 0x8048b78
    }
}

// Address range: 0x8048b7a - 0x8048bd5
void fun6(void) {
    // 0x8048b7a
    int32_t v1;
    int32_t * v2 = (int32_t *)(v1 + 8); // 0x8048b83_0
    int32_t v3 = *v2; // esi
    *v2 = 0;
    if (v3 == 0) {
        // 0x8048bd1
        return;
    }
    int32_t v4 = v3; // 0x8048b93
    while (true) {
        int32_t v5 = 0; // 0x8048baa17
        int32_t v6; // 0x8048bb5
        int32_t v7; // 0x8048bb8
        if (v1 != 0) {
            int32_t v8 = *(int32_t *)v4; // 0x8048bc9
            if (*(int32_t *)v1 > v8) {
                int32_t v9 = *(int32_t *)(v1 + 8); // 0x8048b9b4
                int32_t v10 = v1;
                int32_t v11; // ecx
                int32_t v12; // 0x8048ba621
                if (v9 != 0) {
                    int32_t v13 = v1; // 0x8048ba69
                    while (true) {
                        // 0x8048ba2
                        if (*(int32_t *)v9 > v8) {
                            int32_t v14 = *(int32_t *)(v9 + 8); // 0x8048b9b
                            if (v14 == 0) {
                                v10 = v9;
                                // break -> 0x8048baa
                                break;
                            }
                            v13 = v9;
                            v9 = v14;
                            // continue -> 0x8048ba2
                            continue;
                        } else {
                            // 0x8048baa
                            v11 = v9;
                            if (v13 == v9) {
                                // 0x8048bae
                                v7 = v13;
                                v6 = v4;
                                // branch -> 0x8048bb5
                              lab_0x8048bb5_2:;
                                int32_t * v15 = (int32_t *)(v6 + 8); // 0x8048bb5_0
                                *v15 = v7;
                                int32_t v16 = *v15; // 0x8048bbb
                                if (v16 == 0) {
                                    // 0x8048bd1
                                    return;
                                }
                                // 0x8048bbf
                                v3 = v16;
                                v4 = v16;
                                // branch -> 0x8048bc5
                                break;
                            } else {
                                v12 = v13;
                            }
                        }
                      lab_0x8048bb2_2:
                        // 0x8048bb2
                        *(int32_t *)(v12 + 8) = v4;
                        v7 = v11;
                        v6 = v3;
                        // branch -> 0x8048bb5
                        goto lab_0x8048bb5_2;
                    }
                    // 0x8048baa
                    v11 = 0;
                    v12 = v10;
                    // branch -> 0x8048bb2
                    goto lab_0x8048bb2_2;
                }
                // 0x8048baa
                v11 = 0;
                v12 = v10;
                // branch -> 0x8048bb2
                goto lab_0x8048bb2_2;
            } else {
                v5 = v1;
            }
        }
        // 0x8048bae
        v7 = v5;
        v6 = v4;
        // branch -> 0x8048bb5
        goto lab_0x8048bb5_2;
    }
}

// Address range: 0x8048bd6 - 0x8048c26
void fun7(void) {
    int32_t v1 = g2; // 0x8048bd9
    g1 = -1;
    struct struct_1 * v2;
    if (v2 == NULL) {
        // 0x8048c21
        g2 = v1;
        return;
    }
    int32_t v3 = v2->e0; // 0x8048bec
    g2 = v3;
    int32_t v4;
    if (v3 > v4) {
        // 0x8048bf2
        fun7();
        g1 *= 2;
        // branch -> 0x8048c21
        // 0x8048c21
        g2 = v1;
        return;
    }
    // 0x8048c05
    g1 = 0;
    if (v3 != v4) {
        // 0x8048c0e
        fun7();
        g1 = 2 * g1 | 1;
        // branch -> 0x8048c21
    }
    // 0x8048c21
    g2 = v1;
}

// Address range: 0x8048c27 - 0x8048c8c
void secret_phase(void) {
    int32_t v1 = g2; // 0x8048c2a
    read_line();
    char * endptr = NULL; // bp-24
    int32_t str_as_l = strtol((char *)g1, &endptr, 10); // 0x8048c46
    g2 = str_as_l;
    int32_t v2 = str_as_l; // 0x8048c5c
    if (str_as_l >= 1002) {
        // 0x8048c57
        explode_bomb();
        v2 = g2;
        // branch -> 0x8048c5c
    }
    // 0x8048c5c
    endptr = (char *)v2;
    fun7();
    if (g1 != 6) {
        // 0x8048c71
        explode_bomb();
        // branch -> 0x8048c76
    }
    // 0x8048c76
    puts("Wow! You've defused the secret stage!");
    phase_defused();
    g2 = v1;
}

// Address range: 0x8048c8d - 0x8048cd1
void phase_6(void) {
    int32_t v1 = g2; // 0x8048c90
    char * endptr = NULL; // bp-24
    char * str;
    int32_t str_as_l = strtol(str, &endptr, 10); // 0x8048caa
    g2 = str_as_l;
    fun6();
    int32_t v2 = *(int32_t *)(*(int32_t *)(str_as_l + 8) + 8); // 0x8048cc0
    if (*(int32_t *)v2 != g2) {
        // 0x8048cc7
        explode_bomb();
        // branch -> 0x8048ccc
    }
    // 0x8048ccc
    g2 = v1;
}

// Address range: 0x8048cd2 - 0x8048d22
void phase_5(void) {
    int32_t v1 = g4; // 0x8048cd6
    int32_t v2 = g2; // 0x8048cd7
    char * v3;
    g2 = (int32_t)*v3;
    string_length();
    if (g1 != 6) {
        // 0x8048ceb
        explode_bomb();
        // branch -> 0x8048cf0
    }
    int32_t v4 = 0; // 0x8048d06
    // branch -> 0x8048cff
    int32_t v5; // 0x8048d06
    for (uint32_t i = 0; i < 6; i++) {
        int32_t v6 = v3[i] % 16; // 0x8048d03
        g4 = v6;
        v5 = *(int32_t *)(4 * v6 | 0x8049880) + v4;
        // PHI copies at the loop end
        v4 = v5;
        // loop 0x8048cff end
    }
    // 0x8048d11
    if (v5 != 45) {
        // 0x8048d16
        explode_bomb();
        // branch -> 0x8048d1b
    }
    // 0x8048d1b
    g2 = v2;
    g4 = v1;
}

// Address range: 0x8048d23 - 0x8048d6b
void phase_4(void) {
    char * str;
    char * v1;
    if (sscanf(str, "%d", &v1) != 1) {
        // 0x8048d4e
        explode_bomb();
        // branch -> 0x8048d53
        // 0x8048d53
        func4();
        if (g1 != 0x1cb91) {
            // 0x8048d65
            explode_bomb();
            // branch -> 0x8048d6a
        }
        // 0x8048d6a
        return;
    }
    // 0x8048d48
    if (v1 <= NULL) {
        // 0x8048d4e
        explode_bomb();
        // branch -> 0x8048d53
    }
    // 0x8048d53
    func4();
    if (g1 != 0x1cb91) {
        // 0x8048d65
        explode_bomb();
        // branch -> 0x8048d6a
    }
}

// Address range: 0x8048d6c - 0x8048dfa
void phase_3(void) {
    char * str;
    int32_t v1;
    int32_t v2;
    if (sscanf(str, "%d %d", &v1, &v2) <= 1) {
        // 0x8048d98
        explode_bomb();
        // branch -> 0x8048d9d
    }
    // 0x8048d9d
    int32_t v3; // 0x8048def
    switch (v1) {
        default: {
            // 0x8048de5
            explode_bomb();
            v3 = 0;
            // branch -> 0x8048def
            break;
        }
        case 0: {
            // 0x8048db4
            v3 = 680;
            // branch -> 0x8048def
            break;
        }
        case 1: {
            // 0x8048dad
            v3 = 214;
            // branch -> 0x8048def
            break;
        }
        case 2: {
            // 0x8048dbb
            v3 = 760;
            // branch -> 0x8048def
            break;
        }
        case 3: {
            // 0x8048dc2
            v3 = 873;
            // branch -> 0x8048def
            break;
        }
        case 4: {
            // 0x8048dc9
            v3 = 809;
            // branch -> 0x8048def
            break;
        }
        case 5: {
            // 0x8048dd0
            v3 = 874;
            // branch -> 0x8048def
            break;
        }
        case 6: {
            // 0x8048dd7
            v3 = 86;
            // branch -> 0x8048def
            break;
        }
        case 7: {
            // 0x8048dde
            v3 = 934;
            // branch -> 0x8048def
            break;
        }
    }
    // 0x8048def
    if (v3 != v2) {
        // 0x8048df4
        explode_bomb();
        // branch -> 0x8048df9
    }
}

// Address range: 0x8048dfb - 0x8048e37
void phase_2(void) {
    int32_t v1 = g4; // 0x8048dfe
    int32_t v2 = g2; // bp-12
    read_six_numbers();
    int32_t * v3;
    int32_t v4 = (int32_t)&v3; // 0x8048e15_0
    g2 = v4;
    int32_t v5 = &v2; // 0x8048e18_0
    g4 = v5;
    // branch -> 0x8048e1b
    while (true) {
        int32_t v6 = v5; // 0x8048e2d
        int32_t v7 = v4; // 0x8048e2a
        int32_t * v8;
        if (v3[v4] != v8[v4] + 5) {
            // 0x8048e25
            explode_bomb();
            v6 = g4;
            v7 = g2;
            // branch -> 0x8048e2a
        }
        int32_t v9 = v7 + 4; // 0x8048e2a
        g2 = v9;
        if (v9 == v6) {
            // break -> 0x8048e31
            break;
        }
        v5 = v6;
        v4 = v9;
        // continue -> 0x8048e1b
    }
    // 0x8048e31
    g2 = v2;
    g4 = v1;
}

// Address range: 0x8048e38 - 0x8048e6f
void phase_1(void) {
    // 0x8048e38
    strings_not_equal();
    if (g1 != 0) {
        // 0x8048e55
        explode_bomb();
        // branch -> 0x8048e5a
    }
}

// Address range: 0x8048e70 - 0x8048e8a
void string_length(void) {
    g1 = 0;
    struct struct_2 * v1;
    if (v1->e0 == 0) {
        // 0x8048e89
        return;
    }
    int32_t v2 = 1; // 0x8048e80
    g1 = v2;
    while (*(char *)(v2 + (int32_t)v1) != 0) {
        // 0x8048e80
        v2++;
        g1 = v2;
        // continue -> 0x8048e80
    }
}

// Address range: 0x8048e8b - 0x8048eec
void strings_not_equal(void) {
    // 0x8048e8b
    struct struct_2 * v1;
    int32_t v2 = (int32_t)v1; // ebx
    struct struct_2 * v3;
    int32_t v4 = (int32_t)v3; // esi
    string_length();
    string_length();
    unsigned char v5 = *(char *)v2; // 0x8048eb0
    int32_t v6;
    if (v5 != 0) {
        // 0x8048eb7
        if ((int32_t)v5 == (int32_t)*(char *)v4) {
            int32_t v7 = 0; // 0x8048ec7
            // branch -> 0x8048ece
            while (true) {
                char v8 = *(char *)(v2 + 1 + v7); // 0x8048ece
                if (v8 != 0) {
                    // 0x8048ec2
                    if (v8 != *(char *)(v4 + 1 + v7)) {
                        // break -> 0x8048ee5
                        break;
                    }
                    v7++;
                    // continue -> 0x8048ece
                    continue;
                }
                // 0x8048ee5
                g1 = 0;
                return;
            }
            // 0x8048ee5
            g1 = 1;
            return;
        }
        v6 = 1;
    } else {
        v6 = 0;
    }
    // 0x8048ee5
    g1 = v6;
}

// Address range: 0x8048eed - 0x8049145
void send_msg(void) {
    int32_t v1 = g3; // 0x8048ef0
    int32_t v2 = g4; // 0x8048ef1
    int32_t v3 = g2; // 0x8048ef2
    int32_t fd = dup(0); // 0x8048f00
    if (fd == -1) {
        // 0x8048f0d
        puts("ERROR: dup(0) error");
        exit(8);
        // UNREACHABLE
    }
    // 0x8048f25
    if (close(0) == -1) {
        // 0x8048f36
        puts("ERROR: close error");
        exit(8);
        // UNREACHABLE
    }
    struct struct__IO_FILE * tmp_file = tmpfile(); // 0x8048f4e
    if (tmp_file == NULL) {
        // 0x8048f59
        puts("ERROR: tmpfile error");
        exit(8);
        // UNREACHABLE
    }
    // 0x8048f71
    fwrite("Subject: Bomb notification\n", 1, 27, tmp_file);
    fputc(10, tmp_file);
    char * str2 = cuserid(NULL); // 0x8048fa8
    int32_t str;
    if (str2 == NULL) {
        // 0x8048fb1
        str = 0x6f626f6e;
        // branch -> 0x8048fd5
    } else {
        // 0x8048fc6
        strcpy((char *)&str, str2);
        // branch -> 0x8048fd5
    }
    // 0x8048fd5
    char * v4;
    if (v4 != NULL) {
        // if_8048fe3_0_true
        // branch -> after_if_8048fe3_0
    }
    int32_t v5 = g9;
    fprintf(tmp_file, "bomb-header:%s:%d:%s:%s:%d\n", "Fall15bomb", g5, &str, "defused", g9);
    if (g9 < 1) {
        // 0x804906d
        rewind(tmp_file);
        sprintf((char *)0x804aea0, "%s %s@%s", "/usr/sbin/sendmail -bm", "bomb", "cs.uml.edu");
        if (system((char *)0x804aea0) != 0) {
            // 0x80490b1
            puts("ERROR: notification error");
            exit(8);
            // UNREACHABLE
        }
        // 0x80490c9
        if (fclose(tmp_file) != 0) {
            // 0x80490d5
            puts("ERROR: fclose(tmp) error");
            exit(8);
            // UNREACHABLE
        }
        // 0x80490ed
        if (dup(fd) != 0) {
            // 0x80490fc
            puts("ERROR: dup(tmpstdin) error");
            exit(8);
            // UNREACHABLE
        }
        // 0x8049114
        if (close(fd) != 0) {
            // 0x8049123
            puts("ERROR: close(tmpstdin)");
            exit(8);
            // UNREACHABLE
        }
        // 0x804913b
        g2 = v3;
        g4 = v2;
        g3 = v1;
        return;
    }
    // 0x8049025
    g4 = 0x804a860;
    int32_t v6 = 1; // 0x804902f
    g2 = v6;
    v5 = 0x804a860;
    fprintf(tmp_file, "bomb-string:%s:%d:%s:%d:%s\n", "Fall15bomb", g5, &str, v6, &v5);
    int32_t v7 = g4 + 80; // 0x8049062
    g4 = v7;
    int32_t v8 = g2; // 0x8049065
    // branch -> 0x804902f
    while (g9 > v8) {
        // 0x804902f
        v6 = v8 + 1;
        g2 = v6;
        v5 = v7;
        fprintf(tmp_file, "bomb-string:%s:%d:%s:%d:%s\n", "Fall15bomb", g5, &str, v6, &v5);
        v7 = g4 + 80;
        g4 = v7;
        v8 = g2;
        // continue -> 0x804902f
    }
    // 0x804906d
    rewind(tmp_file);
    sprintf((char *)0x804aea0, "%s %s@%s", "/usr/sbin/sendmail -bm", "bomb", "cs.uml.edu");
    if (system((char *)0x804aea0) != 0) {
        // 0x80490b1
        puts("ERROR: notification error");
        exit(8);
        // UNREACHABLE
    }
    // 0x80490c9
    if (fclose(tmp_file) != 0) {
        // 0x80490d5
        puts("ERROR: fclose(tmp) error");
        exit(8);
        // UNREACHABLE
    }
    // 0x80490ed
    if (dup(fd) != 0) {
        // 0x80490fc
        puts("ERROR: dup(tmpstdin) error");
        exit(8);
        // UNREACHABLE
    }
    // 0x8049114
    if (close(fd) != 0) {
        // 0x8049123
        puts("ERROR: close(tmpstdin)");
        exit(8);
        // UNREACHABLE
    }
    // 0x804913b
    g2 = v3;
    g4 = v2;
    g3 = v1;
}

// Address range: 0x8049146 - 0x80491d5
void phase_defused(void) {
    int32_t str = 1; // bp-124
    send_msg();
    if (g9 == 6) {
        // 0x8049161
        str = 0x804a950;
        int32_t v1;
        int32_t v2;
        if (sscanf((char *)&str, "%d %s", &v2, &v1) == 2) {
            // 0x8049188
            strings_not_equal();
            if (g1 == 0) {
                // 0x804919f
                str = (int32_t)"Curses, you've found the secret phase!";
                puts("Curses, you've found the secret phase!");
                str = (int32_t)"But finding it and solving it are quite different...";
                puts("But finding it and solving it are quite different...");
                secret_phase();
                // branch -> 0x80491bc
            }
        }
        // 0x80491bc
        str = (int32_t)"Congratulations! You've defused the bomb!";
        puts("Congratulations! You've defused the bomb!");
        str = (int32_t)"Your instructor has been notified and will verify your solution.";
        puts("Your instructor has been notified and will verify your solution.");
        // branch -> 0x80491d4
    }
}

// Address range: 0x80491d6 - 0x8049217
void explode_bomb(void) {
    // 0x80491d6
    puts("\nBOOM!!!");
    puts("The bomb has blown up.");
    send_msg();
    puts("Your instructor has been notified.");
    exit(8);
    // UNREACHABLE
}

// Address range: 0x8049218 - 0x8049266
void read_six_numbers(void) {
    // 0x8049218
    char * v1;
    int32_t v2 = (int32_t)v1; // 0x804921e
    char * v3 = (char *)(v2 + 20); // bp-16
    char * v4 = (char *)(v2 + 16); // bp-20
    char * v5 = (char *)(v2 + 12); // bp-24
    char * v6 = (char *)(v2 + 8); // bp-28
    char * v7 = (char *)(v2 + 4); // bp-32
    char * str;
    uint32_t items_assigned = sscanf(str, "%d %d %d %d %d %d", &v1, &v7, &v6, &v5, &v4, &v3); // 0x8049256
    if (items_assigned <= 5) {
        // 0x8049260
        explode_bomb();
        // branch -> 0x8049265
    }
}

// Address range: 0x8049267 - 0x804929b
void blank_line(void) {
    char * v1;
    int32_t v2 = (int32_t)*v1; // 0x804926c_0
    int32_t v3 = v2; // esi
    unsigned char v4 = v1[v2]; // 0x804928c6
    if (v4 == 0) {
        // 0x8049298
        return;
    }
    int32_t v5 = v4; // ebx
    while (true) {
        // 0x8049271
        __ctype_b_loc();
        int32_t v6 = *(int32_t *)g1; // 0x8049279
        g1 = v6;
        if (*(char *)(v6 + 1 + 0x1000000 * v5 / 0x800000) == 32) {
            // 0x8049298
            return;
        }
        int32_t v7 = v3 + 1; // 0x8049289
        v3 = v7;
        unsigned char v8 = v1[v7]; // 0x804928c
        v5 = v8;
        if (v8 == 0) {
            // break -> 0x8049298
            break;
        }
        // continue -> 0x8049271
    }
}

// Address range: 0x804929c - 0x80492e5
void skip(void) {
    int32_t str = 80 * g9 + 0x804a860; // 0x80492bf3
    if (fgets((char *)str, 80, (struct struct__IO_FILE *)infile) == NULL) {
        // 0x80492de
        return;
    }
    g1 = str;
    blank_line();
    int32_t str2 = 80 * g9 + 0x804a860; // 0x80492bf
    while (fgets((char *)str2, 80, (struct struct__IO_FILE *)infile) != NULL) {
        // 0x80492d2
        g1 = str2;
        blank_line();
        str2 = 80 * g9 + 0x804a860;
        // continue -> 0x80492d2
    }
}

// Address range: 0x80492e6 - 0x80493c3
void read_line(void) {
    int32_t v1 = g3; // 0x80492e9
    int32_t v2 = g2; // 0x80492ea
    skip();
    int32_t len; // 0x8049372
    int32_t v3; // 0x804938f
    int32_t v4; // 0x80493a1
    int32_t v5; // 0x80493a9
    if (g1 != 0) {
        // 0x8049357
        len = strlen((char *)(80 * g9 + 0x804a860));
        g2 = len;
        v4 = len;
        if (len == 79) {
            // 0x804937e
            puts("Error: Input line too long");
            explode_bomb();
            v4 = g2;
            // branch -> 0x804938f
        }
        // 0x804938f
        v3 = g9;
        *(char *)(v4 + 0x804a85f + 80 * v3) = 0;
        v5 = v3;
        g9 = v5 + 1;
        g1 = 16 * (4 * v3 + v5) + 0x804a860;
        g2 = v2;
        g3 = v1;
        return;
    }
    int32_t v6 = (int32_t)infile; // 0x80492f7
    g1 = v6;
    if (v6 == g7) {
        // 0x8049304
        puts("Error: Premature EOF on stdin");
        explode_bomb();
        // branch -> 0x8049357
        // 0x8049357
        len = strlen((char *)(80 * g9 + 0x804a860));
        g2 = len;
        v4 = len;
        if (len == 79) {
            // 0x804937e
            puts("Error: Input line too long");
            explode_bomb();
            v4 = g2;
            // branch -> 0x804938f
        }
        // 0x804938f
        v3 = g9;
        *(char *)(v4 + 0x804a85f + 80 * v3) = 0;
        v5 = v3;
        g9 = v5 + 1;
        g1 = 16 * (4 * v3 + v5) + 0x804a860;
        g2 = v2;
        g3 = v1;
        return;
    }
    // 0x8049317
    if (getenv("GRADE_BOMB") != NULL) {
        // 0x8049327
        exit(0);
        // UNREACHABLE
    }
    // 0x8049333
    infile = (struct _IO_FILE *)g7;
    skip();
    if (g1 == 0) {
        // 0x8049346
        puts("Error: Premature EOF on stdin");
        explode_bomb();
        // branch -> 0x8049357
    }
    // 0x8049357
    len = strlen((char *)(80 * g9 + 0x804a860));
    g2 = len;
    v4 = len;
    if (len == 79) {
        // 0x804937e
        puts("Error: Input line too long");
        explode_bomb();
        v4 = g2;
        // branch -> 0x804938f
    }
    // 0x804938f
    v3 = g9;
    *(char *)(v4 + 0x804a85f + 80 * v3) = 0;
    v5 = v3;
    g9 = v5 + 1;
    g1 = 16 * (4 * v3 + v5) + 0x804a860;
    g2 = v2;
    g3 = v1;
}

// Address range: 0x80493e9 - 0x8049443
int32_t sig_handler(int32_t a1) {
    // 0x80493e9
    puts("So you think you can stop the bomb with ctrl-c, do you?");
    sleep(3);
    printf("Well...");
    int32_t stream = g8; // bp-28
    fflush((struct struct__IO_FILE *)&stream);
    stream = 1;
    sleep(1);
    stream = 0x8049a8d;
    puts("OK. :-)");
    stream = 16;
    exit(16);
    // UNREACHABLE
}

// Address range: 0x8049444 - 0x8049530
void open_clientfd(void) {
    int32_t sock_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_IP); // 0x8049463
    if (sock_fd <= 0) {
        // 0x804946e
        puts("Bad host (1).");
        exit(8);
        // UNREACHABLE
    }
    // 0x8049486
    char * name;
    int32_t * v1 = gethostbyname(name); // 0x804948c
    int32_t v2 = (int32_t)v1; // 0x8049491_0
    if (v1 == NULL) {
        // 0x8049495
        puts("Bad host (2).");
        exit(8);
        // UNREACHABLE
    }
    // 0x80494ad
    int16_t v3;
    int32_t addr = &v3; // ebx
    int32_t data = 0;
    v3 = 2;
    int32_t n = *(int32_t *)(v2 + 12); // 0x80494d1
    int32_t str = *(int32_t *)(v2 + 16); // 0x80494df
    bcopy((char *)*(int32_t *)str, (char *)&data, n);
    if (connect(sock_fd, (struct sockaddr *)addr, 16) > 0) {
        // 0x8049528
        return;
    }
    // 0x8049510
    puts("Bad host (3).");
    exit(8);
    // UNREACHABLE
}

// Address range: 0x8049531 - 0x80495ef
void initialize_bomb(void) {
    int32_t v1 = g3; // 0x8049534
    int32_t v2 = g4; // 0x8049535
    int32_t v3 = g2; // 0x8049536
    signal(SIGINT, (void (*)(int32_t))sig_handler);
    int32_t name;
    int32_t str2 = &name; // 0x8049556_0
    if (gethostname((char *)&name) != 0) {
        // 0x804957d
        puts("Bad host (4)");
        exit(8);
        // UNREACHABLE
    }
    char * v4 = g6[0];
    g2 = 0;
    g4 = str2;
    g3 = 0x804a6e0;
    if (v4 == NULL) {
        // 0x80495d5
        puts("Bad host (5).");
        exit(8);
        // UNREACHABLE
    }
    int32_t str = (int32_t)v4; // 0x8049599
    while (true) {
        // 0x8049595
        if (strcasecmp((char *)str, (char *)str2) == 0) {
            // 0x80495b1
            open_clientfd();
            close(0);
            g2 = v3;
            g4 = v2;
            g3 = v1;
            return;
        }
        // 0x80495a5
        g2++;
        char * v5 = g6[0]; // 0x80495a8
        if (v5 == NULL) {
            // 0x80495d5
            puts("Bad host (5).");
            exit(8);
            // UNREACHABLE
        }
        // 0x80495a5
        str2 = g4;
        str = (int32_t)v5;
        // branch -> 0x8049595
    }
}

// --------------- Dynamically Linked Functions ---------------

// void __ctype_b_loc(void);
// void bcopy(const void *, void *, size_t);
// int close(int);
// int connect(int, const struct sockaddr *, socklen_t);
// __caddr_t cuserid(__caddr_t __buf);
// int dup(int fildes);
// void exit(int);
// int fclose(FILE *);
// int fflush(FILE *);
// char * fgets(char *restrict, int, FILE *restrict);
// FILE * fopen(const char *restrict, const char *restrict);
// int fprintf(FILE *restrict, const char *restrict, ...);
// int fputc(int, FILE *);
// size_t fwrite(const void *restrict, size_t, size_t, FILE *restrict);
// char * getenv(const char *);
// struct hostent *gethostbyname(const char *);
// int gethostname(__caddr_t __name);
// int printf(const char *restrict, ...);
// int puts(const char *);
// void rewind(FILE *);
// sighandler_t signal(int signum, sighandler_t handler);
// unsigned int sleep(unsigned int seconds);
// int socket(int domain, int type, int protocol);
// int sprintf(char *restrict, const char *restrict, ...);
// int sscanf(const char *restrict, const char *restrict, ...);
// int strcasecmp(const char *, const char *);
// char * strcpy(char *restrict, const char *restrict);
// long strtol(const char *restrict, char **restrict, int);
// int system(const char *);
// FILE * tmpfile();

// --------------- Instruction-Idiom Functions ----------------

// int32_t strlen(char * a1);

// --------------------- Meta-Information ---------------------

// Detected compiler/packer: gcc (4.4.7)
// Detected language: C
// Detected functions: 23
// Decompiler release: v2.1.1.1 (2015-11-18)
// Decompilation date: 2015-11-25 18:00:56