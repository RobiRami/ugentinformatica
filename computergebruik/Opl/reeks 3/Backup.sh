find -newermt "Oct 12" -type f -exec cp {} {}.BACKUP ";" //DATUM MOET ALTIJD AANGEPAST WORDEN
//OF// find -mtime -0.5  -type f -exec cp {} {}.BACKUP ";" //FILTER OP DE LAATSTE 12 UUR; IPV 24 WAT -1 DOET
