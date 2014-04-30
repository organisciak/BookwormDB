# `field_descriptions.json`

The `field_descriptions.json` file is metadata about the metadata. This defines how the keys in `jsoncatalog.txt` will be interpreted. Not all data you put in will have the same purpose. Some fields (like `policalParty` or `subject`) will be **categorical** elements suitable for choosing from a dropdown menu; others (like `publish_year` or `authorBirthYear`) will be time variables you'll want to display on the X axis; yet others (like `authorName`) might be fields you want to allow in searches, but which web users would never see as a full list. This file is where you.

### The automatic guesser

If you don't enter in a field_descriptions.json, Bookworm will simply guess based on the name and layout of the fields what kind of data is stored in them. There's a really good chance this will fail, so don't rely on it very heavily.

But see the chapter of "Future Plans" below for one option to use field names from a defined ontology (like Dublin Core) to automatically handle data.

### Constraints on field names

Bookworm creation may fail and throw an error if put in a key name that does any of the following things:

* Contains any character besides the 26 English letters and the underscore `([A-Za-z_])+`
* Is the same as the name of a MySQL reserved word, such as:
    * field
    * group
    * in
    * limit


### Future options




Here is an example of the `field_descriptions.json` file from the Open Library Bookworm:
``` {js}
[
    {"field":"title","datatype":"etc","type":"text","unique":true},
    {"field":"lc0","datatype":"categorical","type":"character","unique":true},
    {"field":"lc1","datatype":"categorical","type":"character","unique":true},
    {"field":"lc2","datatype":"etc","type":"integer","unique":true},
    {"field":"publishers","datatype":"etc","type":"character","unique":false},

    {"field":"subjects","datatype":"categorical","type":"character","unique":false},
    {"field":"publish_country","datatype":"categorical","type":"character","unique":true},
    {"field":"publish_places","datatype":"categorical","type":"character","unique":false},
    {"field":"publish","datatype":"time","type":"character","unique":true,"derived":[
        {"resolution":"year"}
    ]},
    {"field":"searchstring","datatype":"searchstring","type":"text","unique":true}
]
```


### Derived fields
