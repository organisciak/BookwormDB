# Defining a Token

It matters what a word is, but there's no single definition that will satisfy everyone.

Bookworm tokenizes using a rather complicated regular expression designed to approximate, as closely as possible, the method used for the 2009 Michel-Aiden Science paper and the accompanying resource, Google Ngrams.

We don't use the 2012 methods because they include a number of strange optimizations, such as [tokenizing "won't" to "will not"]().

The full regular expression is defined in the python code as the following (as of April 20014). The final compiled regex compiles looking for the most complicated token-matching strings first, and as it goes on finds simpler and simpler forms.

This requires the python `regex` module to support unicode regular expression phrases such as `\p{L}` (which matches any unicode letter in any language.

``` {python}
    possessive = MasterExpression + ur"'s"
    numbers = r"(?:[\$])?\d+"
    decimals = numbers + r"\.\d+"
    abbreviation = r"(?:mr|ms|mrs|dr|prof|rev|rep|sen|st|sr|jr|ft|gen|adm|lt|col|etc)\."
    sharps = r"[a-gjxA-GJX]#"
    punctuators = r"[^\p{L}\p{Z}]"

    bigregex = re.compile("|".join([decimals,possessive,numbers,abbreviation,sharps,punctuators,MasterExpression]),re.UNICODE|re.IGNORECASE)
```
