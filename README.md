# JC Desktop Pad – Releases

Dépôt public des mises à jour de **JCharles desktop** : le logiciel y lit `version.json` pour proposer automatiquement
la mise à jour du programme (installateur Windows dans *Releases*) et du firmware (`firmware.bin`).

Projet principal : JC_Desktop_Pad (privé).

## Pièces 3D corrigées / updated 3D parts
Dossier `stl/` : couvercle V2 avec le trou du micro et son berceau à clips (`V2_couvercle_micro_rond.stl`
pour une carte INMP441 ronde Ø14, `V2_couvercle_micro_rect.stl` pour un module 18,5 x 14,5 mm),
`V2_couvercle.stl` sans micro, et la source OpenSCAD `boitier_v2.scad`.
Folder `stl/`: V2 lid with the microphone hole and its snap-in cradle, plus the OpenSCAD source.

## Firmware (code source public / public source)
Dossier `firmware-source/` : code source Arduino du firmware, fichier `.bin` prêt à installer et câblage, pour la V1 et la V2 (licence CC BY-NC 4.0).
Folder `firmware-source/`: Arduino firmware source, ready-to-flash `.bin` and wiring, for V1 and V2 (CC BY-NC 4.0 license).
