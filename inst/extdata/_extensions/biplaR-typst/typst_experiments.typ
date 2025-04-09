// Some definitions presupposed by pandoc's typst output.
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = [
  #line(start: (25%,0%), end: (75%,0%))
]

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// Some quarto-specific definitions.

#show raw.where(block: true): block.with(
    fill: luma(230), 
    width: 100%, 
    inset: 8pt, 
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let d = (:)
  let fields = old_block.fields()
  fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.amount
  }
  return block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == "string" {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == "content" {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

#show figure: it => {
  if type(it.kind) != "string" {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let old_title = old_title_block.body.body.children.at(2)

  // TODO use custom separator if available
  let new_title = if empty(old_title) {
    [#kind #it.counter.display()]
  } else {
    [#kind #it.counter.display(): #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block, 
    block_with_new_content(
      old_title_block.body, 
      old_title_block.body.body.children.at(0) +
      old_title_block.body.body.children.at(1) +
      new_title))

  block_with_new_content(old_callout,
    new_title_block +
    old_callout.body.children.at(1))
}

#show ref: it => locate(loc => {
  let target = query(it.target, loc).first()
  if it.at("supplement", default: none) == none {
    it
    return
  }

  let sup = it.supplement.text.matches(regex("^45127368-afa1-446a-820f-fc64c546b2c5%(.*)")).at(0, default: none)
  if sup != none {
    let parent_id = sup.captures.first()
    let parent_figure = query(label(parent_id), loc).first()
    let parent_location = parent_figure.location()

    let counters = numbering(
      parent_figure.at("numbering"), 
      ..parent_figure.at("counter").at(parent_location))
      
    let subcounter = numbering(
      target.at("numbering"),
      ..target.at("counter").at(target.location()))
    
    // NOTE there's a nonbreaking space in the block below
    link(target.location(), [#parent_figure.at("supplement") #counters#subcounter])
  } else {
    it
  }
})

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color, 
        width: 100%, 
        inset: 8pt)[#text(icon_color, weight: 900)[#icon] #title]) +
      block(
        inset: 1pt, 
        width: 100%, 
        block(fill: white, width: 100%, inset: 8pt, body)))
}



#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
#show: doc => article(
  title: [Experimente mit Typst],
  authors: (
    ( name: [Sarah Gerhard],
      affiliation: [],
      email: [] ),
    ),
  date: [23. Mai 2024],
  lang: "de",
  paper: "a4",
  font: ("Arial",),
  fontsize: 10.5pt,
  toc_title: [Inhaltsverzeichnis],
  toc_depth: 3,
  cols: 1,
  doc,
)



#set page(
    margin: (inside: 2.5cm, outside: 3.5cm, top: 5.4cm, bottom: 3cm),
    header: align(left)[#image("images/logo_ktzh_flag_71x71.png", height: 20%)]
)
= Ausgangslage
<ausgangslage>
Das Rendern von PDF-Dokumenten mit Quarto und der aktuellen LaTeX-Vorlage der Bildungsplanung birgt ein paar Tücken \(cf.~pdf\_template.qmd in diesem Repo). Möglicherweise funktioniert das Rendern via MikTex zudem mit dem digitalen Arbeitsplatz \(DAP) ab Oktober nicht mehr. Ab der Version 1.4 unterstützt Quarto auch typst, eine relativ neue Alternative zu LaTeX. Diese Unterlage unternimmt erste Gehversuche mit dieser Variante.

= Dokumentation
<dokumentation>
Dokumentation zu Quarto und typst findet sich hier: \
https:\/\/quarto.org/docs/output-formats/typst.html

Das Tutorial zu typst selbst ist hier zu finden: \
https:\/\/typst.app/docs/tutorial/

Tipps zum Seitenlayout gibt es hier \
https:\/\/typst.app/docs/guides/page-setup-guide/

= YAML-Header
<yaml-header>
== Template und Seitenlayout
<template-und-seitenlayout>
\[TODO!\] Hier kommt ein Text mit Erklärungen hin.

== Titelseite
<titelseite>
== Inhaltsverzeichnis
<inhaltsverzeichnis>
Das Inhaltsverzeichnis kann im YAML-Header über die Option `toc: true` aktiviert werden. Mit `toc-title: Inhalt` kann der Titel angepasst werden. `tod-depth` steuert, wie viele Ebenen im Verzeichnis angezeigt werden.

== Position der Abbildungen
<position-der-abbildungen>
\[TODO!\] Hier kommt ein Text mit Erklärungen hin.

= Abbildungen
<abbildungen>
Die Abbildungen werden direkt aus dem Chunk generiert. Der Titel kann über die Chunk-Optionen mitgegeben werden. Wird mit der Chunk-Option ein Label gesetzt \(`label: fig-ex`), wird die Abbildung automatisch nummeriert und kann mit `@fig-ex` referenziert werden \(@fig-ex).

#block[
```r
plot <- ggplot(diamonds, aes(x = price, y = carat, colour = color)) +
    geom_point() +
    biplaR::getTheme() +
    theme(legend.position = "right")

plot
```

#block[
#figure([
#box(width: 396.0pt, image("typst_experiments_files/figure-typst/fig-ex-1.svg"))
], caption: figure.caption(
position: top, 
[
Irgendeine Beispielgrafik
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
numbering: "1", 
)
<fig-ex>


]
]
Datenquelle: Beispiel-Dataset aus dem ggplot-Package

== Schriftart
<schriftart>
Im Unterschied zur LaTeX-Template gibt es keine Probleme mit Arial Narrow in Abbildungen.

== Untertitel
<untertitel>
Gemäss bisheriger Praxis verfügen Abbildungen der Abteilung Bildungsmonitoring neben einem Titel und einer Angabe zur Datenquelle auch über einen Untertitel.

Die Chunk-Option `fig-subcap` kann eventuell dafür genutzt werden. Allerdings ist diese für die Beschriftung von mehreren Abbildungen unter einem gemeinsamen übergeordneten Titel gedacht. Aktuell wurde noch kein Weg gefunden, die automatische Nummerierung von `fig-subcap` zu entfernen.

== Datenquelle
<datenquelle>
Die Datenquelle wird direkt unter der Abbildung eingefügt. Bei einer wiederkehrenden Angabe empfiehlt es sich, einen String im Setup-Chunk zu definieren und diesen immer wieder einzusetzen. Falls etwas angepasst werden soll, kann die Anpassung bequem für alle Abbildungen im Setup-Chunk vorgenommen werden.
