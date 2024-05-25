tikz_path=$1 # relative path
tikz_tex=$(basename ${tikz_path}) # path in same directory
tikz_name=${tikz_tex%.*} # name without extension
template_tex=template.tex

cp $tikz_path build/${tikz_tex}
cd build

cp $template_tex main.tex
sed -i "s/replacement/${tikz_name}.tex/" main.tex

pdflatex -shell-escape -interaction=nonstopmode main.tex
cp main.pdf ../pdf/${tikz_name}.pdf
convert -density 600 main.pdf -quality 100 main.png
convert main.png -background white -alpha remove -alpha off main.png.white
mv main.png ../image/${tikz_name}.png
mv main.png.white ../image/${tikz_name}_white.png

rm main.*
rm ${tikz_tex}