# Chapter 3: Web Front Ends


## The Primary GUI
The primary GUI is at https://github.com/econpy/BookwormGUI. It runs on the highcharts library, and generates attractive line charts over time. It's easy to use, meets a significant percentage of use cases, and has some very nice design.

## The D3 platform

I (Ben) have written a set of code in [D3](d3js.org) that makes a wide variety of visualizations possible, and handles the shared elements (creating dropdown selectors, fetching data through the API, making elements display information on hover and link to a search on click) transparently so new coders can just write D3 code to work with a transparent bookworm.data element.

It's uglier, though, and doesn't currently support multiple queries in the same plot.

One advantage is that since it's written as libraries that simply dump onto an existing web page, it's much easier to integrate **elements** into a wider page: for example, a treemap of a libraries contents could be deposited onto the front page without requiring any of the various interface elements.
