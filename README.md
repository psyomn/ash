Axios
-----
Axios is an "Ada eXtremely Ineffectual Object Oriented Server". And it is just 
that!

This is a case study of mine to learn the language, and as a side effect learn
more about protocols through practice. 

More elaboration will not be done here - refer to the latex manual to read 
about everything. Hopefully this document and provided sources can help whoever
comes accross it.

Quick tips
----------

* Building the server

To build the project you need to go into ./axios and run the following

  gnatmake -P axios.gpr -p -Xmode=release

Then, go inside the binary directory and run

  ./axios

Make sure that www1, and www2 exist within the bin directory (that is where
the static content is served from).

* Building the documentation

You will need pdflatex, and bibtex to compile the document (and some other
packages such as listings etc). You simply need to go inside the document 
directory ./doc and run

  make

That generates the document. If listings are messed up, run make a few more
times.
