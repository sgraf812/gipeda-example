# Depends on the gipeda executable being accessible at $1 (defaults to ..), also the site/ folder and the install-jslibs.sh script must be at $1
# So to recap, $1 must point to a folder with
#   1. The gipeda executable
#   2. The site/ scaffold
#   3. The install-jslibs.sh script
p=${1:-..}

# 1. req: bare repository/ folder
rm -rf repository
git clone --bare https://github.com/Gabriel439/Haskell-Pipes-Library repository/

# 2. req: site folder scaffolding from the gipeda repository with installed js libs
rm -rf site/
cp -r $p/site ./site
sh $p/install-jslibs.sh

# 3. req: site/out/results folder with the raw data to visualize
mkdir -p site/out/results
stack cloben.hs ./repository 77813a976b5a7d73ffdef224e6175254e0cca5b3 > site/out/results/77813a976b5a7d73ffdef224e6175254e0cca5b3.csv

# 4. gipeda supports 3 different `LogSource`s (grep for that in gipeda.hs). 2 of them require a ./logs/ directory (either a git repository or not) containing <SHA>.log files for each benchmarked commit SHA. gipeda will call ./log2csv on each of them which will produce appropriate CSV files with the data. The 3rd `LogSource` mode used here is to not create a ./log/ directory at all and instead directly write out the CSV output of cloben into ./site/out/results. That way, we don't have to provide a ./log2csv script.
# Due to unwieldy circumstances in the implementation of gipeda, we have to provide a link to it in ./:
ln $p/gipeda ./gipeda
$p/gipeda -j

# 5. Start a server at ./site. Just accessing site/index.html with file:// doesn't work because of cross site requests.
cd site
python3 -m http.server
cd ..

