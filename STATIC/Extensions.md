# Extensions

There are a lot of logical ways to extend out Bookworm to work with established tools. We want to make this easy without requiring enormous bloat.

## Installing/creating extensions.

The /extensions folder in a Bookworm


## Existing/under development Extensions

### Topic Modeling

The topic modeling extension adjusts the master wordcounts file so that each word has a topic assignment.

#### Challenges

1. Currently, it doesn't filter for stopwords, which is mathematically justifiable but hurts interpretability.
2. Should there be multiple topics run?

### The Bootstrapper.

It's hard to quantify the error associated with counts over time. We like to treat words as

### Geopositioner

Given the name of field that contains place names, add in a longitude-latitude formatted set of places.
The real trick here is exactly nailing the standard Bookworm format. We've used separate Lat,Lon, before, but I now think that's inefficient.

### Geotagger

The Geotagger will work by parsing a text using the Stanford NLTK named entity extractor, pulling out persons, locations, and entities. The results could then be run through the geopositioner plugin.

## Extensions we want

### The Linked Open Data interchange.

This would be the most amazing thing possible, and possibly worth building in as core funcationality. In essence: say you have a field `author_id`, and that corresponds to an identifier on some other page. By using a linked open data interchange, you could simply specify the source and the middle element of an RDF triple, and have the values automatically pulled in by some SPARQL process or something. The use of specific URIs in the `field_descriptions.json` field would enormously facilitate this.

### Serial Killer
Implement the Ngrams serial killer algorithm in Bookworm. Been done once, but might be a nice pocket example of how this can work on the OL/Hathi data.

### University Linker.

On my mind because of one Bookworm in particular, but with an academic audience it might be nice to have some pathway to populating texts that contain unstructured text of university names with all the data about universities in ICOADS.


### Genderation

Given a field that contains names (first or complete), add fields to the Bookworm that include gender both as a flat determination and as a probability. Ideally, should take some logic about the birth year of the person into account (19th century Leslies are male, etc.). Could be implemented using my old code, which is a bit more flexible, or Lincoln Mullen's R package, which I've used on one Bookworm.

