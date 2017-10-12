### command 1 ###
mkdir geheim cdmap popcds klassiekecds toppers filmmap thriller romantisch persoonlijk

### command 2 ###
touch nevermind_nirvana.txt help_beatles.txt musicology_prince.txt

### command 3 ###
mv thriller filmmap && mv romantisch filmmap

### command 4 ###
mv filmmap persoonlijk

### command 5 ###
mv *.txt toppers

### command 6 ###
mv *cds cdmap

### command 7 ###
chmod 700 ~ 

### command 8 ###
cp -R cdmap ~ && cp -R toppers ~ && chmod -R o-r ~/cdmap ~/toppers

### command 9 ###
touch geheim/geheim1.txt && chmod o-r,u-r geheim

### command 10 ###
chmod o+r,u+r geheim && rm -R geheim persoonlijk