# `field_descriptions.json`

The `field_descriptions.json` file is metadata about the metadata.


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
