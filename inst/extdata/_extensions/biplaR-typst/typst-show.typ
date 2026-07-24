#show: body => report(
  title: [$title$],
  subtitle: [$subtitle$],
  date: [$date$],
  author: [$author$],
  abstract: [$abstract$],
  $if(toc)$
  toc: $toc$,
  $endif$

  body,
)
