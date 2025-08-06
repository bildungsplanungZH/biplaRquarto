# Damit einige Test funktionieren, muss ein .profile.yml vorhanden sein...
set_author("Testlauf", "Autorin", "testlauf.autorin@dir.zh.ch",
           "Direktion", "Amt", "Abteilung", path = test_path())

use_quarto("report", "biplaR-html", author_path = test_path())
