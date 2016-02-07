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

# 3. req: logs folder with the raw data to visualize
rm -rf logs
mkdir logs/
stack cloben.hs ./repository 77813a976b5a7d73ffdef224e6175254e0cca5b3 > logs/77813a976b5a7d73ffdef224e6175254e0cca5b3.log

# 4. This will convert the raw data in *.log files to the expected CSV format by using the local log2csv script. That's just calling cat for us, since the logs contain already the CSVs.
# Note that the gipeda executable has to be present (at least a link) in ./.
chmod +x ./log2csv
ln $p/gipeda ./gipeda
./gipeda -j

# 5. Start a server at ./site. Just accessing site/index.html with file:// doesn't work because of cross site requests.
cd site
python3 -m http.server
cd ..

