#include <stdio.h>
#include <string.h>

#include "LeoUTF8.h"

static void print_bytes(const char *label, const unsigned char *bytes, size_t length)
{
    size_t i;

    printf("%s:", label);
    for (i = 0; i < length; i++) {
        printf(" %02X", (unsigned int)bytes[i]);
    }
    printf("\n");
}

static int expect_ok(const char *label, LeoUTF8Status status)
{
    if (status != LEO_UTF8_OK) {
        fprintf(stderr, "%s failed: %s\n", label, LeoUTF8StatusMessage(status));
        return 1;
    }

    printf("%s: OK\n", label);
    return 0;
}

int main(void)
{
    const unsigned char sample[] =
        "Gr" "\xC3" "\xB6" "\xC3" "\x9F" "e "
        "\xC3" "\x84" "\xC3" "\x96" "\xC3" "\x9C"
        " Stra" "\xC3" "\x9F" "e";

    size_t sampleLen;
    size_t codepoints;
    unsigned char *nfd;
    unsigned char *casefold;
    size_t nfdLen;
    size_t casefoldLen;
    LeoUTF8Status status;

    sampleLen = sizeof(sample) - 1;
    codepoints = 0;
    nfd = 0;
    casefold = 0;
    nfdLen = 0;
    casefoldLen = 0;

    printf("LeooRexx LeoUTF8 consumer probe\n");
    printf("LeoUTF8 version: %s\n", LeoUTF8Version());

    printf("sample: %s\n", sample);
    print_bytes("sample bytes", sample, sampleLen);

    status = LeoUTF8ValidateBytes(sample, sampleLen);
    if (expect_ok("validate sample", status) != 0) {
        return 1;
    }

    status = LeoUTF8CodepointCountBytes(sample, sampleLen, &codepoints);
    if (expect_ok("count sample codepoints", status) != 0) {
        return 1;
    }

    printf("sample codepoints: %lu\n", (unsigned long)codepoints);

    status = LeoUTF8NormalizeNFDBytes(sample, sampleLen, &nfd, &nfdLen);
    if (expect_ok("normalize sample to NFD", status) != 0) {
        return 1;
    }

    printf("NFD: %s\n", nfd);
    print_bytes("NFD bytes", nfd, nfdLen);

    status = LeoUTF8CaseFoldBytes(sample, sampleLen, &casefold, &casefoldLen);
    if (expect_ok("casefold sample", status) != 0) {
        LeoUTF8Free(nfd);
        return 1;
    }

    printf("casefold: %s\n", casefold);
    print_bytes("casefold bytes", casefold, casefoldLen);

    LeoUTF8Free(casefold);
    LeoUTF8Free(nfd);

    printf("LeooRexx LeoUTF8 consumer probe passed.\n");
    return 0;
}
