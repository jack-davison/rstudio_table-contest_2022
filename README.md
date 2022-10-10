<a href="https://rpubs.com/JackDavison/gt-openair"><div align="center"><img width="800" src="./man/banner.png"/></div></a>
<h1 align="center">
Tabulating DuBois
</h1>
<h2 align="center">
 RStudio Table Contest 2022 Entry: <a href="https://jack-davison.quarto.pub/tabulating-dubois/">[View Submission]</a>
</h2>

<div align = "center">

W.E.B. DuBois was a trailblazer in many ways, and is known for his use of data visualisation to challenge the racism of the early 20th century.

DuBois’ work makes me think of contrast. It contrasts the lives of white and black Americans in his day. It is obviously hand-drawn, yet still meticulously neat. It is immediately familiar in its basic geometry, but subverts expectations as the shapes loop, spiral and fan.

DuBois can teach us about race in the 20th century, but he can also teach us to play with the expectations of the media with which we present data to tell more impactful stories.
</div>

## 📝 The Tables

This submission to the [RStudio (Posit) Table Contest 2022](https://www.rstudio.com/blog/rstudio-table-contest-2022/) takes the form of eight tables which attempt to reflect the style and/or spirit of some of W.E.B. DuBois 20th century visualisations. It effectively revisits [The #DuBois Challenge](https://nightingaledvs.com/the-dubois-challenge/) but using data tables as the medium instead of graphs.

All of the tables are "static" and built using [`{gt}`](https://gt.rstudio.com/index.html), a powerful system for constructing beautiful HTML tables.

There are arguably three categories of tables in this study:

1.  Tables which try to closely reflect DuBois' original plate (e.g., [Conjugal Condition](https://jack-davison.quarto.pub/tabulating-dubois/docs/challenges/conjugal.html)).

2.  Tables which try to capture the spirit of what DuBois was trying to do, but translated to a table medium (e.g., [Occupations of Black and White Americans...](https://jack-davison.quarto.pub/tabulating-dubois/docs/challenges/occupation.html))

3.  Tables which are effectively graphs/maps, and have been created to see how far `{gt}` can be pushed (e.g., [Migration of Black Americans in Georgia](https://jack-davison.quarto.pub/tabulating-dubois/docs/challenges/location.html))

While not all of these tables are as effective as the original plates, it is at least an interesting exercise to see how data storytelling can be effectively translated from one medium to another.

![](./man/comparison.png)

## 🗃️ The Repository

This repository contains all of the files required to build a [quarto](https://quarto.org/) website, so many of them may not be particularly interesting to individually examine. I would direct you to two folders in particular:

1.  [tbl](./tbl) - This folder contains *.png* images of every table in this repository.
2.  [src](./src) - This folder has a R scripts which will create each of the tables on the website.

Note that no local data is required to reproduce the tables; all data is pulled from publicly available GitHub repos.

## 👋 About the Author
**I am an R Developer and Data Analyst, having recently completed a PhD in atmospheric chemistry at the [Wolfson Atmospheric Chemistry Laboratories](https://www.york.ac.uk/chemistry/research/wacl/) at the [University of York](https://www.york.ac.uk/) in the United Kingdom, investigating how emissions from road transport impact the air we breathe.** I accomplish much of my work through using [R](https://www.r-project.org/) in the [RStudio](https://rstudio.com/) IDE, with a focus on the [`{tidyverse}`](https://www.tidyverse.org/) suite of R packages and the dedicated air quality analysis package [`{openair}`](https://davidcarslaw.github.io/openair). I'm also keen on teaching reproducible data analysis through R, having become an [Rstudio Certified Tidyverse Instructor](https://education.rstudio.com/trainers/) in 2021.

<div align = "center">

 &nbsp;&nbsp;&nbsp;🐤 <a href="https://twitter.com/JDavison_">Twitter<a>&nbsp;&nbsp;&nbsp;
 •
 &nbsp;&nbsp;&nbsp;💼 <a href="https://www.linkedin.com/in/jack-davison/">LinkedIn<a>&nbsp;&nbsp;&nbsp;
 •
 &nbsp;&nbsp;&nbsp;<img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"> <a href="https://orcid.org/0000-0003-2653-6615/">ORCID<a>&nbsp;&nbsp;&nbsp;
</div>
