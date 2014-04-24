# Future Plans

## Bookworm and TEI/XML

TEI (and XML more generally) contains rich data about individual portions of a text.

## Bookworm and SOLR

Integration with SOLR makes an enormous amount of sense: Solr handles text queries very well, and is getting increasingly good at things like

### Needs before moving
There are a number of things possible in MySQL that I (Ben) want to make sure we preserve before moving over to a Solr solution altogether, because I think they are enormously important for a variety of research.

1. **Faceted queries.** Earlier versions of Solr didn't make multidimensional responses possible: they can be replicated through lots of smaller searches, but this is the single most important thing in making Bookworm a text analytics engine, not just a search engine.
2. **Word counts and Text counts**. In some cases it's appropropriate to count words and not texts; in other cases, the opposite is the case. Default Solr implementations have simply returned the number of texts with a match; this is not acceptable for real quantitative analysis.
3. Live stemming, tokenization, and

