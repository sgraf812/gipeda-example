# gipeda-example

A quite minimal (regarding scope) and maximal (regarding bisected dependencies) example of using cloben in conjunction with gipeda to produce a benchmark site for a specific commit of the Haskell pipes library.

The actual explaining comments are in `serveResults.sh`, which assumes that gipeda was built prior to executing this and that `stack` is installed for using cloben as a script.

See this as a documentary of how I got a feeling for how to use gipeda.

# How to use this

A prerequisite is having a folder containing the gipeda executable, the site/ folder containing the scaffolding from the gipeda repository and the install-jslibs.sh script from the gipeda repository.

Pass that path to `serveResults.sh` and wait for the web server to serve the benchmark results:

```
$ sh serveResults.sh path/to/dependencies
```

`serveResults.sh` is the most minimal example I can come up with that is relatively relocatable wrt. the gipeda folder.
