#let report(
  title: none,
  subtitle: none,
  date: none,
  author: none,
  abstract: none,
  content,
) = {
  set page(
    paper: "a4",
    margin: (top: 6.15cm, bottom: 1cm, outside: 4.6cm, inside: 2cm),
    footer: [],
    background: context {
      if counter(page).get().first() < 2 [
        #polygon(
          fill: rgb("#009EE0"),
          stroke: rgb("#009EE0"),
            (0.1cm, 8.5cm),
            (21.1cm, 29.5cm),
            (0.1cm,  29.5cm))
      ]
    },

    header: context {
      if counter(page).get().first() > 1 [
      #rect(
        width: 100%,
        height: 6.15cm,
        stroke: white,
        block([
            #grid(
            columns: (69.3%, 1.7%, 29%),
            align(right + horizon)[
                #image("images/logo_ktzh_flag_71x71.png",
                height: 6mm)],
            align(center)[],
            align(left + horizon)[
                #text(
                title,
                font: "Arial",
                fill: black,
                )
                #linebreak()
                #counter(page).display(
  "1/1",
  both: true,
)],
                )
      ]))
  ] else [
    #grid(
      columns: (20%, 80%),
      align(left + horizon)[#image("images/logo_leu.svg", width: 2.25cm)],
      align(left + horizon)[#text("Kanton Zürich\nLieblingsdirektion\nBeispielamt"
      )])
  ]})

  set par(justify: true)

  set text(
    lang: "de",
    region: "CH",
    font: "Arial",
    size: 11pt,
  )

  set list(marker: [--])

  set heading(numbering: "1.")

  show heading: it => {
    let sizes = (
      "1": 24pt, // Heading level 1
      "2": 16pt, // Heading level 2
      "3": 11pt, // Heading level 3
    )

    let level = str(it.level)
    let size = sizes.at(level)

    set text(
      font: "Arial",
      size: size,
      weight: "black",
    )
    align(left)[#it]
  }



text(
  title,
  font: "Arial",
  size: 24pt,
  fill: black,
  weight: "black",
)

linebreak()

text(
  subtitle,
  font: "Arial",
  size: 16pt,
  fill: black,
  weight: "black",
)

  date
  author
  linebreak()

 text(
   "Klassifikation: "
 )
  abstract
  pagebreak()

  outline()
  pagebreak()

  content
}
