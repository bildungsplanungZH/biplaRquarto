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

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subrefnumbering: "1a",
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => numbering(subrefnumbering, n-super, quartosubfloatcounter.get().first() + 1))
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => {
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          }

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
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
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: white, width: 100%, inset: 8pt, body))
      }
    )
}



#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
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
  toc_indent: 1.5em,
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
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
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
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)
#show: doc => article(
  title: [Experimente mit Typst],
  authors: (
    ( name: [Sarah Gerhard],
      affiliation: [],
      email: [] ),
    ),
  date: [9. April 2025],
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
    header: align(left)[#image("images/logo_ktzh_flag_71x71.png", height: 20%)
                        #text("Kanton Zürich")]
)
= Ausgangslage
<ausgangslage>
Das Rendern von PDF-Dokumenten mit Quarto und der aktuellen LaTeX-Vorlage der Bildungsplanung birgt ein paar Tücken (cf.~pdf\_template.qmd in diesem Repo). Möglicherweise funktioniert das Rendern via MikTex zudem mit dem digitalen Arbeitsplatz (DAP) ab Oktober nicht mehr. Ab der Version 1.4 unterstützt Quarto auch typst, eine relativ neue Alternative zu LaTeX. Diese Unterlage unternimmt erste Gehversuche mit dieser Variante.

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
Die Abbildungen werden direkt aus dem Chunk generiert. Der Titel kann über die Chunk-Optionen mitgegeben werden. Wird mit der Chunk-Option ein Label gesetzt (`label: fig-ex`), wird die Abbildung automatisch nummeriert und kann mit `@fig-ex` referenziert werden (@fig-ex).

```r
plot <- ggplot(diamonds, aes(x = price, y = carat, colour = color)) +
    geom_point() +
    biplaR::getTheme() +
    theme(legend.position = "right")

plot
```

#figure([
#box(image("typst_experiments_files/figure-typst/fig-ex-1.svg"))
], caption: figure.caption(
position: top, 
[
Irgendeine Beispielgrafik
]), 
kind: "quarto-float-fig", 
supplement: "Abbildung", 
)
<fig-ex>


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
