// ====================================================================
// BOÎTIER PUPITRE (15°) - FORME HARICOT - V6
// ESP32-S3 + écran 4.0" LAFVIN + joystick + 3 touches tactiles TTP223
// --------------------------------------------------------------------
// V6 : - potentiomètre supprimé
//      - implantation compacte, calculée : la longueur et la profondeur
//        découlent des composants (voir "IMPLANTATION")
//      - touches, joystick et voyant alignés sur l'axe de l'écran
//      - cuvettes en rotate_extrude (rendu ~10x plus rapide qu'avec sphere)
//      - modes "boitier" et "couvercle" pour exporter chaque STL à part
//      - fente lumineuse 75 mm + rail et clips pour le ruban LED
//      - haut-parleur plaqué contre la paroi gauche (2 pions + grille), glissières pour l'ampli MAX98357A
// Conservé de la V4/V5 : forme haricot, pente 15°, avant 28 mm, mur 3,
//   socle chanfreiné 3, bord de couvercle R2, feuillure 1.5 x 2 / jeu 0.25,
//   4 vis M3 fraisées, joystick identique au prototype, face arrière.
// ====================================================================
$fa = 6;
$fs = 0.5;

// --- Mode d'affichage ------------------------------------------------
// "impression" : les 2 pièces côte à côte
// "boitier" / "couvercle" : une seule pièce (export STL plus rapide)
// "touches"    : les 3 pastilles tactiles, à imprimer cuvette vers le haut
// "bride"      : la bride qui verrouille l'ESP32-S3 dans son support
// "assemblage" : couvercle posé sur le boîtier
// "verif_bord" : conflits de place -> doit être VIDE
// "contour"    : le contour haricot seul en 2D
mode = "impression";

// ====================================================================
// COMPOSANTS (cotes mesurées ou à mesurer)
// ====================================================================
// --- Écran 4.0" LAFVIN (B0CQ87KN3Q) ----------------------------------
// Mesuré au pied à coulisse (photos du 07/11) :
ecran_pcb = [108.2, 61.8];    // carte, largeur x hauteur
ecran_entraxe = [102.1, 55.3];// entraxe des trous
ecran_fenetre = [85.7, 58.2]; // zone affichée
// la zone affichée est décalée d'environ 2.6 mm vers le côté opposé au grand
// connecteur J2 : ici J2 est à GAUCHE (côté touches), J4 à droite (côté joystick)
ecran_fenetre_decal = [2.6, 0]; // centre fenêtre / centre des trous (+Y = vers l'arrière)
ecran_trous_decal = [0, 0];   // trous centrés sur la carte (marges 3.05 et 3.25 mm)
pion_ecran_sous_plaque = 5.0;  // hauteur des pions écran mesurée SOUS la plaque du couvercle
hauteur_pion_ecran = pion_ecran_sous_plaque - (2.0 - 0.25);  // = sous la lèvre (lèvre 1.75)
d_pion_ecran = 7;
d_vis_ecran = 2.2;            // M2.5

// --- Touches tactiles TTP223 (module HW-763) -------------------------
// !!! VALEURS LUES SUR LES PHOTOS : À CONFIRMER AU PIED À COULISSE !!!
ttp_pcb = [11, 14];           // carte : X (côté sans broches) x Y (côté broches)
ttp_ep_pcb = 1.0;             // épaisseur de la carte seule
ttp_rond_decal = 1.0;         // centre du rond TOUCH / centre carte, côté opposé aux broches
ttp_soudure = 1.5;            // soudures du connecteur qui dépassent côté TOUCH (mesuré)
ttp_zone_soudure = 2.5;       // bande des soudures, depuis le bord côté broches
ttp_paroi_mini = 0.6;         // plastique mini entre une soudure et la cuvette
ttp_broches = 8;              // dépassement des broches coudées après le bord de la carte
ttp_sens = [-1, -1, -1];      // broches, de l'avant vers l'arrière : +1 = arrière, -1 = avant
ttp_jeu = 0.2;                // jeu autour de la carte
ttp_serrage = 0.15;           // les nervures mordent de 0.15 sur la carte
cuvette_d = 18;               // cuvette "empreinte de doigt"
// Les touches sont des pastilles imprimées à part, cuvette vers le haut (propre),
// emboîtées par le dessus dans le couvercle (collerette chanfreinée + détrompeur)
touche_d = 22;                // diamètre du corps de la pastille
touche_chanfrein = 0.8;       // collerette en haut, chanfrein à 45°
touche_jeu = 0.15;            // jeu radial dans le couvercle
touche_cle = [2, 1];          // détrompeur côté broches : largeur, saillie
cuvette_prof = 1.5;
ttp_fond = 1.2;               // plastique entre le doigt et la carte (sensibilité)
d_led_touche = 3.2;           // LED témoin à droite de chaque touche

// --- Joystick PS2 / KY-023 (identique au prototype) ------------------
joy_entraxe = [21, 27];
joy_decal_axe = [1, 1];       // passage Ø28 décalé +1/+1 par rapport aux pions
joy_pcb = [26, 34];
d_joystick = 28;
chanfrein_joystick = 2.5;
hauteur_pion_joystick = 9;
d_pion_joystick = 7;
d_vis_joystick = 2.8;

// --- Micro INMP441 (option dictée vocale) ---------------------------
// Trou acoustique dans la façade, en avant du joystick, et berceau à clips
// sous le couvercle : la carte s'encliquette, orifice du micro face au trou.
// Les deux formes de module courantes sont prévues (voir micro_forme).
micro_forme = "rond";         // "rond" : carte ronde Ø14 ; "rect" : carte 18,5 x 14,5 ; "aucun" : pas de micro
micro_dist = 35;              // axe du joystick -> axe du micro (vers l'avant)
d_trou_micro = 2;             // trou acoustique dans la façade
micro_carte_d = 14.6;         // forme ronde : Ø de la carte + jeu
micro_carte = [18.9, 15.1];   // forme rect : carte + jeu
micro_ep = 1.7;               // épaisseur de la carte + jeu
micro_log = 0.8;              // logement dans le couvercle (reste 3,2 mm de façade)
micro_mur = 1.6;              // épaisseur du collier
micro_griffe = 0.8;           // retenue des griffes
micro_h = 3.2;                // hauteur du collier sous le couvercle
micro_fente = 2.4;            // fentes du collier (souplesse + sortie des fils)
// la carte rectangulaire est plus large : on la recule un peu du bord arrondi du couvercle
micro_decal = (micro_forme == "rond") ? [0, 0] : [-3, 0];

// --- Voyant, face arrière, lumière avant -----------------------------
d_led_voyant = 5.2;
// ouverture des 2 USB-C (carte montée à l'envers, prises sous la carte, support abaissé de 8 mm)
usb = [27, 2.2, 8.7];         // largeur, z bas, z haut (depuis le dessous du boîtier) - axe des prises à ~5.5
charge = [14, 13, 19];        // prise de recharge, même forme
// Carte chargeur HW-373 (TP4056 USB-C) : posée sur 2 rails, tenue par 2 parois à crochet
// !!! DIMENSIONS DE LA CARTE À MESURER !!!
ch_pcb = [17.5, 28, 1.6];     // largeur (X), longueur (vers l'avant), épaisseur
ch_z_dessous = 12;            // dessous de la carte depuis le dessous du boîtier (mesuré)
ch_usb_debord = 0.6;          // la prise USB dépasse du bord arrière de la carte
ch_jeu = 0.2;
// Carte survolteur MT3608 : à plat sur le fond, dans le prolongement du chargeur (devant lui)
// !!! DIMENSIONS À MESURER !!!
mt_pcb = [17, 36, 1.2];       // largeur (X), longueur (Y), épaisseur
mt_haut_comp = 5;             // composant le plus haut au-dessus du PCB (potentiomètre bleu couché)
mt_rail = 3;                  // hauteur des rails (dégage les soudures des fils sous la carte)
mt_ecart = 16;                // entre l'avant du chargeur et l'arrière du survolteur (fils des deux cartes)
// Batterie LiPo 603040 (1000 mAh) à plat, à droite sous le joystick, fils vers l'arrière
bat = [41, 30.5, 6.2];        // longueur, largeur, épaisseur (603040 + marge du ruban adhésif)
bat_jeu = 0.5;                // jamais serrée
bat_centre = [156, 50];       // centre de la batterie (en plan), longueur dans le sens avant-arrière
bat_rebord = 3.5;             // hauteur des rebords
bat_mors = 0.8;               // les crochets mordent de 0.8 mm sur le bord
inter = [19.2, 12.7, 25];     // interrupteur : découpe fabricant 19 x 12.5 mm + 0.2 (impression), z centre
// Support ESP32-S3 (fichier STL fourni, à garder dans le même dossier que ce .scad)
// imprimé avec le boîtier : bout ouvert contre la paroi arrière, sous l'USB central
esp_support_stl = "support_esp32s3_base.stl";
esp_bride_stl = "support_esp32s3_bride.stl";   // bride qui verrouille la carte (pièce séparée)
esp_support_centre_x = 14;    // axe du support dans son propre repère (rails -2.15 / 30.15)
esp = [32.3, 65];             // emprise du support : largeur x longueur (contrôle)
esp_abaisse = 8;              // hauteur retirée au support (plaque de base de 2 mm conservée)
lumiere = [75, 4];            // fente lumineuse avant : longueur, hauteur
// Ruban LED derrière la fente (souple, suit la courbe avant)
// !!! À MESURER : largeur et épaisseur du ruban (LED comprises) !!!
// La bande jaune (LED) s'encastre dans la fente et arrive presque au ras de la façade ;
// les bords blancs du ruban se plaquent à plat contre la paroi intérieure.
// Pion de fixation sur le fond (vis M2.5), avant gauche
pion_fond = [44, 27.5];       // position en plan
pion_fond_h = 5;              // hauteur au-dessus du fond intérieur
pion_fond_d = 7;
ruban_jeu_ep = 0.5;           // jeu en épaisseur
ruban_jeu_h = 0.2;            // jeu en hauteur, en haut et en bas (hauteur d origine)
ruban = [8, 0.2];             // largeur totale 8 mm, épaisseur du circuit (bords) 0.2 mm
ruban_pas_clips = 15;         // un clip haut tous les 15 mm
ruban_long_clip = 5;          // longueur d'un clip

// --- Haut-parleur (boîtier noir à 2 oreilles) ------------------------
// !!! VALEURS LUES SUR LES PHOTOS : À CONFIRMER AU PIED À COULISSE !!!
hp_corps = [31, 31, 15];      // corps : largeur (côté oreilles) x hauteur x profondeur
hp_entraxe = 35;              // entraxe des 2 trous des oreilles
hp_oreilles = 42;             // longueur hors tout, oreille à oreille
hp_oreille_recul = 6;         // face avant -> face d appui des oreilles (lu : ~8 mm au dos de l oreille, oreille ~2 mm)
hp_membrane = 27;             // diamètre visible de la membrane (zone de la grille)
d_vis_hp = 1.7;               // pré-trou pour vis M2 autotaraudeuse (trous des oreilles Ø2)

// --- Ampli I2S MAX98357A ---------------------------------------------
// !!! VALEURS LUES SUR LES PHOTOS : À CONFIRMER !!!
ampli_pcb = [18, 19];         // largeur (bords qui glissent) x hauteur
ampli_ep = 1.6;               // épaisseur de la carte seule
ampli_saillie = 9.5;          // épaisseur hors tout (broches + bornier)

// ====================================================================
// IMPLANTATION (tout est calculé à partir d'ici)
// ====================================================================
marge = 2;                    // jeu mini entre deux composants
x_touches = 18;               // axe des cuvettes
pas_touches = 25;             // écart entre deux touches
x_led_touche = x_touches + touche_d/2 + touche_chanfrein + 1 + d_led_touche/2;
x_ecran_g = x_led_touche + (d_led_touche + 1)/2 + marge;   // bord gauche carte écran
x_ecran_d = x_ecran_g + ecran_pcb[0];
recul_joystick = 22;          // axe des pions joystick -> bout droit
longueur = ceil(x_ecran_d + marge + joy_pcb[0]/2 + recul_joystick);

largeur = 100;                // profondeur au sol (imposée par la colonne de touches)
y_pilier_av = 8;              // axe des piliers avant (en plan)

// Haut-parleur : contre la paroi gauche, vers l'arrière (seul endroit assez haut),
// membrane face à la grille, tenu par 2 pions sortant de la paroi.
// La face se cale toute seule au plus près de la paroi (qui s'arrondit vers l'arrière).
hp_y = 68.5;                  // axe du haut-parleur (en plan)
hp_jeu_paroi = 0.5;           // jeu mini entre la face et la paroi
d_pion_hp = 6;
trou_grille = 2;              // grille : trous Ø2 en nid d'abeille
pas_grille = 3.2;
// Ampli : carte debout dans 2 glissières, parallèle à la face arrière
ampli_c = [46, 66];           // centre (en plan)

// ====================================================================
// FORME & STRUCTURE (validées : ne pas changer sans raison)
// ====================================================================
rayon_bouts = 26;
creux_avant = 6;
demi_corde_creux = 45;
bombe_arriere = 7;
angle = 15;
k_pente = 1 / cos(angle);
largeur_couv = largeur * k_pente;
epaisseur_mur = 3;
chanfrein_socle = 3;
arrondi_couvercle = 2;
chanfrein_ecran = 1.2;
rayon_fenetre = 1.5;
hauteur_avant = 28;
hauteur_arriere = hauteur_avant + largeur * tan(angle);
epaisseur_feuillure = 1.5;
hauteur_feuillure = 2.0;
jeu = 0.25;
epaisseur_couvercle = 4;
h_levre = hauteur_feuillure - jeu;
d_pilier = 9;
d_pretrou_m3 = 2.8;
profondeur_pretrou = 10;

// ====================================================================
// POSITIONS (repère du couvercle : Y le long de la pente)
// ====================================================================
cy = largeur_couv / 2;                      // axe horizontal de la façade
c_carte_ecran = [(x_ecran_g + x_ecran_d)/2, cy];
c_ecran = c_carte_ecran + ecran_trous_decal;  // centre des trous écran
c_joy_axe = [longueur - recul_joystick, cy] + joy_decal_axe;
c_joy = c_joy_axe - joy_decal_axe;            // centre des pions joystick
c_voyant = [c_joy_axe[0], c_joy_axe[1] + d_joystick/2 + chanfrein_joystick + 6];
c_micro = [c_joy_axe[0], c_joy_axe[1] - micro_dist] + micro_decal;
y_touches = [for (i = [-1 : 1]) cy + i * pas_touches];

function grille4(c, e) = [for (sx = [-1, 1], sy = [-1, 1]) [c[0] + sx*e[0]/2, c[1] + sy*e[1]/2]];
pions_joy = grille4(c_joy, joy_entraxe);
pions_ecran = grille4(c_ecran, ecran_entraxe);

// Vis M3 (en plan) : avant sous l'écran, arrière-gauche à 4 mm de l'ESP32
coins = [
    [x_ecran_g + 5, y_pilier_av],
    [x_ecran_d - 5, y_pilier_av],
    [longueur/2 - 40/2 - 8, largeur - y_pilier_av - 1],   // inchangé (X = 63 pour 182 mm)
    [x_ecran_d - 5, largeur - y_pilier_av - 3]
];
coins_couv = [for (c = coins) [c[0], c[1] * k_pente]];

hp_z = epaisseur_mur + hp_corps[1] / 2;       // le haut-parleur pose sur le fond

// Face arrière
usb_x = longueur / 2;
charge_x = longueur / 2 + 32;
inter_x = 42;                 // décalé de 2 mm : marge avec le haut-parleur
lumiere_x = (longueur - lumiere[0]) / 2;
lumiere_z = epaisseur_mur + hauteur_avant/2 - 2;

// ====================================================================
// CONTOUR HARICOT (calculé une fois)
// ====================================================================
pas_contour = 4;
pas_angle = 7.5;

function rect_arrondi_pts(L, W, r) = concat(
    [for (x = [r : pas_contour : L - r - 0.01]) [x, 0]],
    [for (a = [-90 : pas_angle : -0.01]) [L - r + r*cos(a), r + r*sin(a)]],
    [for (y = [r : pas_contour : W - r - 0.01]) [L, y]],
    [for (a = [0 : pas_angle : 89.99]) [L - r + r*cos(a), W - r + r*sin(a)]],
    [for (x = [L - r : -pas_contour : r + 0.01]) [x, W]],
    [for (a = [90 : pas_angle : 179.99]) [r + r*cos(a), W - r + r*sin(a)]],
    [for (y = [W - r : -pas_contour : r + 0.01]) [0, y]],
    [for (a = [180 : pas_angle : 269.99]) [r + r*cos(a), r + r*sin(a)]]
);

function haricot_pt(p) =
    let (u = p[0] - longueur/2,
         creux = abs(u) < demi_corde_creux ? creux_avant * pow(cos(90 * u / demi_corde_creux), 2) : 0,
         recul = bombe_arriere * pow(u / (longueur/2), 2))
    [p[0], p[1] + creux * (1 - p[1]/largeur) - recul * (p[1]/largeur)];

PTS = [for (p = rect_arrondi_pts(longueur, largeur, rayon_bouts)) haricot_pt(p)];
NB_PTS = len(PTS);

// contour rentré de d (le long de la normale), étiré de sy en Y
function contour_pts(d, sy = 1) =
    let (P = [for (p = PTS) [p[0], p[1] * sy]], N = len(P))
    [for (i = [0 : N - 1])
        let (a = P[(i - 1 + N) % N], b = P[(i + 1) % N],
             tx = b[0] - a[0], ty = b[1] - a[1], l = norm([tx, ty]))
        [P[i][0] - d * ty / l, P[i][1] + d * tx / l]];

// Haut-parleur : la face se cale au plus près de la paroi intérieure,
// sans que le corps ni le bout des oreilles ne touchent l'arrondi arrière
function x_paroi(demi) = max([for (p = contour_pts(epaisseur_mur))
                              if (p[0] < longueur/4 && abs(p[1] - hp_y) <= demi) p[0]]);
hp_face_x = max(x_paroi(hp_corps[0]/2 + 1),
                x_paroi(hp_oreilles/2 + 2.5) - hp_oreille_recul) + hp_jeu_paroi;
hp_oreille_x = hp_face_x + hp_oreille_recul;  // plan d'appui des oreilles

module micro2d(j = 0) {
    if (micro_forme == "rond") circle(d = micro_carte_d + 2 * j, $fn = 64);
    else offset(r = j, $fn = 24) square(micro_carte, center = true);
}

// berceau du micro : collier à clips sous le couvercle (carte poussée par le dessous)
module micro_berceau() {
    z_bas = -(micro_log + micro_ep);          // dessous de la carte
    translate([c_micro[0], c_micro[1], 0]) difference() {
        translate([0, 0, -micro_h]) linear_extrude(micro_h + 0.1) micro2d(micro_mur);
        // logement de la carte, puis rampe à 45° et griffes
        translate([0, 0, z_bas - 0.01]) linear_extrude(micro_log + micro_ep + 0.2) micro2d(0);
        hull() {
            translate([0, 0, z_bas - micro_griffe]) linear_extrude(0.01) micro2d(-micro_griffe);
            translate([0, 0, z_bas - 0.01]) linear_extrude(0.01) micro2d(0);
        }
        translate([0, 0, -micro_h - 0.2]) linear_extrude(micro_h - micro_log - micro_ep - micro_griffe + 0.2)
            micro2d(-micro_griffe);
        // fentes : les branches peuvent s'écarter, et les fils sortent par là
        for (a = (micro_forme == "rond") ? [60, 180, 300] : [0, 180])
            rotate(a) translate([-micro_fente/2, 0, -micro_h - 0.1])
                cube([micro_fente, micro_carte[0], micro_h + 0.2]);
    }
}

module haricot2d(d = 0) { polygon(contour_pts(d)); }
module haricot_couv2d(d = 0) { polygon(contour_pts(d, k_pente)); }
module anneau_couv2d(ext, int) { difference() { haricot_couv2d(ext); haricot_couv2d(int); } }

// couches = [[z, retrait], ...] -> un seul polyèdre
module loft(couches, sy = 1) {
    N = NB_PTS;
    M = len(couches);
    pts = [for (c = couches) for (p = contour_pts(c[1], sy)) [p[0], p[1], c[0]]];
    faces = concat(
        [[for (i = [0 : N - 1]) i]],
        [[for (i = [N - 1 : -1 : 0]) (M - 1) * N + i]],
        [for (j = [0 : M - 2]) for (i = [0 : N - 1])
            [j*N + i, (j+1)*N + i, (j+1)*N + (i+1) % N, j*N + (i+1) % N]]);
    polyhedron(points = pts, faces = faces, convexity = 6);
}

module repere_couvercle() {
    translate([0, 0, hauteur_avant]) rotate([angle, 0, 0]) children();
}

// ====================================================================
// PETITS OUTILS
// ====================================================================
module rect_arrondi(taille, h, r) {
    linear_extrude(h) offset(r = r) offset(delta = -r) square(taille);
}
// trou traversant le couvercle (lèvre comprise)
module trou(p, d) {
    translate([p[0], p[1], -h_levre - 2]) cylinder(h = epaisseur_couvercle + h_levre + 4, d = d);
}
// fente horizontale à bouts ronds dans la face arrière
module fente_arriere(x, l, z0, z1, y0, prof) {
    r = (z1 - z0) / 2;
    hull() for (dx = [-1, 1])
        translate([x + dx * (l/2 - r), y0, z0 + r]) rotate([-90, 0, 0]) cylinder(h = prof, r = r);
}

// ====================================================================
// 1. LE BOÎTIER
// ====================================================================
module piliers(h) {
    intersection() {
        union() for (c = coins) {
            s = (c[1] < largeur/2) ? -1 : 1;   // vers le mur le plus proche
            // pré-trou perpendiculaire au couvercle : pilier recentré sur le perçage
            y_c = c[1] + profondeur_pretrou * sin(angle) / 2;
            hull() for (dy = [0, s * 10])
                translate([c[0], y_c + dy, epaisseur_mur]) cylinder(h = h, d = d_pilier);
        }
        linear_extrude(h + epaisseur_mur) haricot2d(1);
    }
}

// --- Haut-parleur : 2 pions depuis la paroi + grille ----------------
// chaque pion part de la paroi et s'arrête au plan des oreilles ;
// il est rogné par le contour pour ne jamais dépasser à l'extérieur
module pions_hp() {
    difference() {
        intersection() {
            for (s = [-1, 1])
                translate([0, hp_y + s * hp_entraxe/2, hp_z]) rotate([0, 90, 0])
                    cylinder(h = hp_oreille_x, d = d_pion_hp);
            linear_extrude(hauteur_arriere) haricot2d(1);
        }
        // pré-trous M2 (6 mm de profondeur)
        for (s = [-1, 1])
            translate([hp_oreille_x + 0.1, hp_y + s * hp_entraxe/2, hp_z])
                rotate([0, -90, 0]) cylinder(h = 6.1, d = d_vis_hp);
    }
}

module grille_hp() {
    r = hp_membrane / 2 - 1;
    n = ceil(r / pas_grille);
    for (i = [-n : n], j = [-n : n]) {
        dy = (i + (abs(j) % 2) / 2) * pas_grille;
        dz = j * pas_grille * sin(60);
        if (dy*dy + dz*dz <= r*r)
            translate([-1, hp_y + dy, hp_z + dz]) rotate([0, 90, 0])
                cylinder(h = hp_face_x, d = trou_grille, $fn = 12);
    }
}

// --- Ruban LED : rail porteur en bas + clips en haut, le long de la face avant ---
// Profil (vu en coupe, la paroi à gauche) :
//   clip haut : petite lèvre qui retient le bord haut du ruban
//   rail bas  : tablette continue + lèvre, dessous en pente à 45° (imprimable)
// Montage : glisser le bord bas du ruban derrière la lèvre du rail, la bande jaune
// face à la fente, puis pousser : la bande entre dans la fente et le bord haut
// passe sous la lèvre des clips. L'adhésif 3M peut rester en plus.
module bande_avant(d0, d1, x0, x1) {
    intersection() {
        difference() { haricot2d(epaisseur_mur + d0); haricot2d(epaisseur_mur + d1); }
        translate([x0, -5]) square([x1 - x0, largeur / 2]);
    }
}

module support_ruban() {
    e = ruban[1] + ruban_jeu_ep;              // logement des bords du ruban (0.2 + jeu)
    p = e + 1.2;                              // saillie totale depuis la paroi
    zb = lumiere_z - ruban[0]/2 - ruban_jeu_h; // dessus du rail bas
    zt = lumiere_z + ruban[0]/2 + ruban_jeu_h; // dessous des clips
    x0 = lumiere_x - 4;
    x1 = lumiere_x + lumiere[0] + 4;
    n = 6;
    // rail bas : tablette + dessous à 45°
    translate([0, 0, zb - 1.2]) linear_extrude(1.2) bande_avant(-0.1, p, x0, x1);
    for (k = [1 : n])
        translate([0, 0, zb - 1.2 - k * p/n]) linear_extrude(p/n + 0.01)
            bande_avant(-0.1, p * (1 - k/n) + 0.01, x0, x1);
    // lèvre du rail bas
    translate([0, 0, zb - 0.01]) linear_extrude(1.2) bande_avant(e, p, x0, x1);
    // clips hauts
    for (x = [x0 : ruban_pas_clips : x1 - ruban_long_clip + 0.01]) {
        translate([0, 0, zt]) linear_extrude(1.2) bande_avant(-0.1, p, x, x + ruban_long_clip);
        translate([0, 0, zt - 1.2]) linear_extrude(1.21) bande_avant(e, p, x, x + ruban_long_clip);
    }
}

// --- Support ESP32-S3 : STL importé, posé sur le fond -----------------
module support_esp() {
    translate([usb_x - esp_support_centre_x, largeur - epaisseur_mur + 0.2, epaisseur_mur - 0.01])
        mirror([0, 1, 0]) support_esp_bas();
}
// support d'origine avec une tranche de 8 mm retirée (de 0.8 à 8.8 mm) :
// tout ce qui est au-dessus (cale sous les USB, rails, bloc à 2 trous) descend de 8 mm
// sans changer de forme -> la carte et la bride se montent exactement comme avant
module support_esp_bas() {
    intersection() { import(esp_support_stl, convexity = 6); translate([-10, -10, -1]) cube([60, 90, 1.81]); }
    translate([0, 0, -esp_abaisse]) intersection() {
        import(esp_support_stl, convexity = 6);
        translate([-10, -10, 0.8 + esp_abaisse - 0.01]) cube([60, 90, 50]);
    }
}

// --- Carte chargeur : 2 rails porteurs + 2 parois souples à crochet ------
// La carte se pousse vers le bas : les crochets s'écartent puis la bloquent.
// La prise USB vient dans la fente arrière. Les 5 mm avant restent libres (soudures).
function y_paroi_int(x) = max([for (p = contour_pts(epaisseur_mur))
                               if (abs(p[0] - x) < 6 && p[1] > largeur/2) p[1]]);
ch_y_arriere = y_paroi_int(charge_x) - 0.3 + ch_usb_debord;   // bord arrière du PCB
ch_y_avant = ch_y_arriere - ch_pcb[1];
mt_x = charge_x;
mt_y = ch_y_avant - mt_ecart - mt_pcb[1] / 2;

// 2 rails porteurs sous les bords + 2 parois souples à crochet sur les grands côtés.
// Renforts (le boîtier s'imprime à plat : une poussée de côté casse une pièce verticale
// le long d'une couche) :
//  - parois de 1.6 mm sur 20 mm de long, avec un congé à 45° à leur pied (côté extérieur)
//  - butées avant (chargeur) posées SUR les rails, prolongées par un contrefort à 45° :
//    la poussée de la prise USB part dans la longueur des rails, jamais en travers des couches
clip_ep = 1.6;                // épaisseur des parois souples
clip_long = 20;               // longueur des parois souples
module support_clip(cx, y_avant, pcb, z_dessous, libre_avant, libre_arriere, butee = false) {
    w = pcb[0] / 2;
    z0 = epaisseur_mur - 0.01;
    zc = z_dessous + pcb[2] + 0.2;
    lw = min(pcb[1] - 4, clip_long);
    yr0 = butee ? y_avant - 3.2 : y_avant + libre_avant;       // début des rails
    for (s = [-1, 1]) {
        xr = cx + (s > 0 ? w - 3 : -w + 0.6);                  // rail (2.4 de large sous le bord)
        translate([xr, yr0, z0]) cube([2.4, y_avant + pcb[1] - libre_arriere - yr0, z_dessous - z0]);
        if (butee) {
            // butée sur le rail, au ras du dessus du PCB
            translate([xr, y_avant - 3.2, z0]) cube([2.4, 3, z_dessous + pcb[2] - z0]);
            // contrefort à 45° devant la butée
            hull() {
                translate([xr, y_avant - 3.2, z0]) cube([2.4, 0.01, z_dessous + pcb[2] - z0]);
                translate([xr, y_avant - 3.2 - (z_dessous + pcb[2] - z0), z0]) cube([2.4, 0.01, 0.01]);
            }
        }
        // paroi souple
        xw = cx + s * (w + ch_jeu) + (s > 0 ? 0 : -clip_ep);
        translate([xw, y_avant + pcb[1]/2 - lw/2, z0]) {
            cube([clip_ep, lw, zc + 1.2 - z0]);
            hull() {                                           // congé au pied, côté extérieur
                cube([clip_ep, lw, 2]);
                translate([s > 0 ? clip_ep : -2, 0, 0]) cube([2, lw, 0.01]);
            }
            hull() {                                           // crochet : dessous plat, dessus en pente
                translate([s > 0 ? -0.5 - ch_jeu : clip_ep, 0, zc - z0]) cube([0.5 + ch_jeu, lw, 0.01]);
                translate([s > 0 ? 0 : clip_ep, 0, zc + 1.2 - z0]) cube([0.01, lw, 0.01]);
            }
        }
    }
}
// chargeur : butées avant (prise USB-C) sur les rails
module support_chargeur() { support_clip(charge_x, ch_y_avant, ch_pcb, ch_z_dessous, 5, 0.5, butee = true); }
// survolteur : 4 mm libres à chaque bout (VIN / VOUT)
module support_survolteur() { support_clip(mt_x, mt_y - mt_pcb[1]/2, mt_pcb, epaisseur_mur + mt_rail, 4, 4); }


// --- Berceau batterie à plat : rebords + 4 languettes à crochet ---------
// Longueur dans le sens avant-arrière, sortie des fils par le petit côté arrière.
module berceau_batterie() {
    L = bat[0] + 2*bat_jeu; W = bat[1] + 2*bat_jeu; H = bat[2] + bat_jeu; e = 1.6;
    translate([bat_centre[0], bat_centre[1], epaisseur_mur - 0.01]) rotate([0, 0, 90]) translate([-L/2, -W/2, 0]) {
        difference() {
            translate([-e, -e, 0]) cube([L + 2*e, W + 2*e, bat_rebord]);
            translate([0, 0, -1]) cube([L, W, bat_rebord + 2]);
            translate([L - 1, W/2 - 8, -1]) cube([e + 2, 16, bat_rebord + 2]);           // sortie des fils
            for (x = [L*0.25 - 6, L*0.75 - 6], y = [-e - 1, W - 1])
                translate([x, y, -1]) cube([12, e + 2, bat_rebord + 2]);                // passages des languettes
        }
        for (x = [L*0.25 - 5, L*0.75 - 5], s = [-1, 1])
            translate([x, s < 0 ? -1.4 : W + 0.2, 0]) {
                cube([10, 1.2, H + 1.2]);
                hull() {                                   // congé au pied, côté extérieur
                    cube([10, 1.2, 2]);
                    translate([0, s < 0 ? -2 : 1.2, 0]) cube([10, 2, 0.01]);
                }
                hull() {
                    translate([0, s < 0 ? 1.2 : -bat_mors, H]) cube([10, bat_mors, 0.01]);
                    translate([0, s < 0 ? 1.2 : 0, H + 1.2]) cube([10, 0.01, 0.01]);
                }
            }
    }
}

// --- Ampli : 2 glissières, la carte s'enfile par le haut ---------------
module glissieres_ampli() {
    g = ampli_ep + 0.4;          // largeur de la rainure
    p = 1.5;                     // profondeur de la rainure
    e = 2;                       // épaisseur des joues
    h = ampli_pcb[1] * 0.6;      // hauteur des glissières
    for (s = [-1, 1]) {
        x_bord = ampli_c[0] + s * (ampli_pcb[0]/2 + 0.2);   // fond de rainure
        difference() {
            translate([s > 0 ? x_bord - p : x_bord - e, ampli_c[1] - g/2 - e, epaisseur_mur - 0.1])
                cube([p + e, g + 2*e, h + 0.1]);
            translate([s > 0 ? x_bord - p - 1 : x_bord, ampli_c[1] - g/2, epaisseur_mur + 1])
                cube([p + 1, g, h + 1]);
        }
    }
}

module boitier_fond() {
    h = hauteur_arriere + 20;
    c = chanfrein_socle;
    difference() {
        union() {
            difference() {
                loft([[0, c], [c, 0], [h, 0]]);
                translate([0, 0, epaisseur_mur]) linear_extrude(h + 10) haricot2d(epaisseur_mur);
            }
            piliers(h);
            pions_hp();
            support_esp();
            support_chargeur();
            support_survolteur();
            berceau_batterie();
            translate([pion_fond[0], pion_fond[1], epaisseur_mur - 0.01])
                cylinder(h = pion_fond_h + 0.01, d = pion_fond_d);
            support_ruban();
            glissieres_ampli();
        }
        repere_couvercle() {
            // coupe inclinée
            translate([-10, -10, 0]) cube([longueur + 20, largeur * 3, hauteur_arriere + 50]);
            // feuillure
            translate([0, 0, -hauteur_feuillure]) linear_extrude(hauteur_feuillure + 0.1)
                anneau_couv2d(epaisseur_mur - epaisseur_feuillure, epaisseur_mur + 0.4);
            // pré-trous M3
            for (p = coins_couv)
                translate([p[0], p[1], -profondeur_pretrou])
                    cylinder(h = profondeur_pretrou + 1, d = d_pretrou_m3);
        }
        fente_arriere(usb_x, usb[0], usb[1], usb[2], largeur - epaisseur_mur - 2, epaisseur_mur + 4);
        fente_arriere(charge_x, charge[0], charge[1], charge[2], largeur - 15, 25);
        translate([inter_x - inter[0]/2, largeur - 15, inter[2] - inter[1]/2])
            cube([inter[0], 25, inter[1]]);
        grille_hp();
        translate([pion_fond[0], pion_fond[1], epaisseur_mur + pion_fond_h - 4.5])   // pré-trou M2.5, 4.5 mm
            cylinder(h = 5, d = d_vis_ecran);
        // barre lumineuse avant
        r = lumiere[1] / 2;
        hull() for (x = [lumiere_x + r, lumiere_x + lumiere[0] - r])
            translate([x, -10, lumiere_z]) rotate([-90, 0, 0])
                cylinder(h = 10 + creux_avant + epaisseur_mur + 3, r = r);
    }
}

// ====================================================================
// 2. LE COUVERCLE (z = 0 sous la plaque, dessus à z = 4)
// ====================================================================
module plaque_couvercle() {
    e = epaisseur_couvercle;
    R = arrondi_couvercle;
    loft(concat([[0, 0]], [for (a = [0 : 15 : 90]) [e - R + R * sin(a), R - R * cos(a)]]), k_pente);
    // lèvre
    translate([0, 0, -h_levre]) linear_extrude(h_levre + 0.1)
        anneau_couv2d(epaisseur_mur - epaisseur_feuillure + jeu, epaisseur_mur + 0.4 - jeu);
}

module chanfreins_joystick() {
    translate([c_joy_axe[0], c_joy_axe[1], epaisseur_couvercle - chanfrein_joystick])
        cylinder(h = chanfrein_joystick + 0.1, d1 = d_joystick, d2 = d_joystick + 2 * chanfrein_joystick);
    translate([c_joy_axe[0], c_joy_axe[1], -h_levre - 0.1])
        cylinder(h = chanfrein_joystick + 0.1, d1 = d_joystick + 2 * chanfrein_joystick, d2 = d_joystick);
}

module fenetre_ecran() {
    p0 = c_ecran + ecran_fenetre_decal - ecran_fenetre / 2;
    h = epaisseur_couvercle + h_levre + hauteur_pion_ecran + 4;
    translate([p0[0], p0[1], -h_levre - hauteur_pion_ecran - 2]) rect_arrondi(ecran_fenetre, h, rayon_fenetre);
    hull() {
        translate([p0[0], p0[1], epaisseur_couvercle - chanfrein_ecran])
            rect_arrondi(ecran_fenetre, 0.01, rayon_fenetre);
        translate([p0[0] - chanfrein_ecran, p0[1] - chanfrein_ecran, epaisseur_couvercle + 0.01])
            rect_arrondi(ecran_fenetre + [2, 2] * chanfrein_ecran, 0.5, rayon_fenetre + chanfrein_ecran);
    }
}

// --- Touches TTP223 : cuvette dessus + poche à clipser dessous -------
// hauteur du fond de la cuvette à la distance rho de son centre
function z_cuvette(rho) =
    let (r = cuvette_d/2, R = (r*r + cuvette_prof*cuvette_prof) / (2 * cuvette_prof))
    rho >= r ? epaisseur_couvercle : epaisseur_couvercle - cuvette_prof + R - sqrt(R*R - rho*rho);
// distance du centre de la cuvette au début de la bande des soudures
rho_soudure = ttp_rond_decal + ttp_pcb[1]/2 + ttp_jeu - ttp_zone_soudure;
// fond de la poche : le plus haut possible (sensibilité) sans que le dégagement
// des soudures ne perce la cuvette
z_face_ttp = min(epaisseur_couvercle - cuvette_prof - ttp_fond,
                 z_cuvette(rho_soudure) - ttp_soudure - 0.3 - ttp_paroi_mini);
fond_reel = epaisseur_couvercle - cuvette_prof - z_face_ttp;   // plastique sous le doigt
z_bas_touche = min(0, z_face_ttp - ttp_ep_pcb - 0.2);         // la pastille dépasse sous le couvercle si besoin
ttp_poche = ttp_pcb + [2, 2] * ttp_jeu;

// retourne la carte autour du centre de la cuvette si les broches vont vers l'avant
module oriente_ttp(p, sens) {
    if (sens < 0) translate(p) mirror([0, 1, 0]) translate(-p) children();
    else children();
}

// calotte sphérique en rotate_extrude : léger à calculer
module cuvette(p) {
    r = cuvette_d / 2;
    R = (r*r + cuvette_prof*cuvette_prof) / (2 * cuvette_prof);
    n = 24;
    translate([p[0], p[1], epaisseur_couvercle - cuvette_prof])
        rotate_extrude($fn = 72)
            polygon(concat([[0, cuvette_prof + 1]],
                           [for (i = [0 : n]) let (q = r * i / n) [q, R - sqrt(R*R - q*q)]],
                           [[r, cuvette_prof + 1]]));
}

// forme extérieure d'une pastille (j = jeu ajouté pour le trou du couvercle)
module forme_touche(p, sens, j = 0, z0 = 0) {
    e = epaisseur_couvercle;
    c = touche_chanfrein;
    translate([p[0], p[1], 0]) {
        translate([0, 0, z0]) cylinder(h = e - c - z0 + 0.01, d = touche_d + 2*j);
        translate([0, 0, e - c]) cylinder(h = c + 0.01 + (j > 0 ? 1 : 0),
                                          d1 = touche_d + 2*j, d2 = touche_d + 2*c + 2*j + (j > 0 ? 2 : 0));
        // détrompeur du côté des broches
        translate([-touche_cle[0]/2 - j, sens > 0 ? 0 : -(touche_d/2 + touche_cle[1] + j), z0])
            cube([touche_cle[0] + 2*j, touche_d/2 + touche_cle[1] + j, e - c - z0]);
    }
}

// pastille seule, dans le repère du couvercle (z_bas_touche < 0 : elle dépasse dessous)
module pastille_touche(p, sens) {
    difference() {
        forme_touche(p, sens, 0, z_bas_touche);
        cuvette(p);
        poche_ttp(p, sens);
    }
}

module poche_ttp(p, sens) {
    oriente_ttp(p, sens) {
        c = p + [0, ttp_rond_decal];
        h = z_face_ttp + h_levre + 2;
        difference() {
            translate([c[0] - ttp_poche[0]/2, c[1] - ttp_poche[1]/2, z_face_ttp - h])
                cube([ttp_poche[0], ttp_poche[1], h]);
            // nervures de serrage : 2 par côté long
            for (sx = [-1, 1], dy = [-0.25, 0.25])
                translate([c[0] + sx * ttp_poche[0]/2, c[1] + dy * ttp_pcb[1], z_face_ttp - h - 1])
                    cylinder(h = h + 2, r = ttp_jeu + ttp_serrage, $fn = 16);
        }
        // dégagement des soudures du connecteur, le long du bord côté broches
        translate([c[0] - ttp_poche[0]/2, c[1] + ttp_poche[1]/2 - ttp_zone_soudure, z_face_ttp - 0.1])
            cube([ttp_poche[0], ttp_zone_soudure, ttp_soudure + 0.3 + 0.1]);
    }
}

module couvercle_superieur() {
    difference() {
        union() {
            difference() { plaque_couvercle(); chanfreins_joystick(); }
            for (p = pions_joy)
                translate([p[0], p[1], -h_levre - hauteur_pion_joystick])
                    cylinder(h = hauteur_pion_joystick + h_levre + 0.1, d = d_pion_joystick);
            for (p = pions_ecran)
                translate([p[0], p[1], -h_levre - hauteur_pion_ecran])
                    cylinder(h = hauteur_pion_ecran + h_levre + 0.1, d = d_pion_ecran);
            if (micro_forme != "aucun") micro_berceau();
        }
        // joystick : passage Ø28 sur toute la hauteur (comme le prototype)
        translate([c_joy_axe[0], c_joy_axe[1], -h_levre - hauteur_pion_joystick - 2])
            cylinder(h = epaisseur_couvercle + h_levre + hauteur_pion_joystick + 4, d = d_joystick);
        fenetre_ecran();
        for (p = pions_joy)
            translate([p[0], p[1], -h_levre - hauteur_pion_joystick - 1])
                cylinder(h = hauteur_pion_joystick + 1, d = d_vis_joystick);
        for (p = pions_ecran)
            translate([p[0], p[1], -h_levre - hauteur_pion_ecran - 1])
                cylinder(h = hauteur_pion_ecran + 1, d = d_vis_ecran);
        for (i = [0 : 2]) {
            p = [x_touches, y_touches[i]];
            forme_touche(p, ttp_sens[i], touche_jeu, -h_levre - 1);
            trou([x_led_touche, y_touches[i]], d_led_touche);
        }
        trou(c_voyant, d_led_voyant);
        // micro : trou acoustique (léger chanfrein en façade) + logement de la carte dessous
        if (micro_forme != "aucun") {
        trou(c_micro, d_trou_micro);
        translate([c_micro[0], c_micro[1], epaisseur_couvercle - 0.6])
            cylinder(h = 0.7, d1 = d_trou_micro, d2 = d_trou_micro + 1.2, $fn = 32);
        translate([c_micro[0], c_micro[1], -0.1]) linear_extrude(micro_log + 0.1) micro2d(0);
        }
        for (p = coins_couv) {
            trou(p, 3.4);
            translate([p[0], p[1], epaisseur_couvercle - 2]) cylinder(h = 2.1, d1 = 3.4, d2 = 6.5);
        }
    }
}

// ====================================================================
// CONTRÔLES 2D (repère couvercle)
// ====================================================================
// une empreinte par composant ; écran et joystick grossis de marge/2
NB_EMPREINTES = 9;
module empreinte(i) {
    m = marge - 0.01;
    if (i < 3) {
        p = [x_touches, y_touches[i]];
        oriente_ttp(p, ttp_sens[i]) {
            c = p + [0, ttp_rond_decal];
            translate([c[0] - ttp_poche[0]/2 - 1, c[1] - ttp_poche[1]/2 - 1])
                square([ttp_poche[0] + 2, ttp_poche[1] + 1 + ttp_broches]);   // carte + broches
        }
    }
    else if (i < 6) translate([x_led_touche, y_touches[i - 3]]) circle(d = d_led_touche + 1);
    else if (i == 6) translate(c_voyant) circle(d = d_led_voyant + 1);
    else if (i == 7) translate(c_carte_ecran) square(ecran_pcb + [m, m], center = true);
    else translate(c_joy) square(joy_pcb + [m, m], center = true);
}
module empreintes_composants() { for (i = [0 : NB_EMPREINTES - 1]) empreinte(i); }

// empreintes en plan (repère du boîtier)
module empreinte_hp() {
    translate([hp_face_x, hp_y - hp_corps[0]/2]) square([hp_corps[2], hp_corps[0]]);
    translate([hp_oreille_x, hp_y - hp_oreilles/2]) square([2, hp_oreilles]);
}
module empreinte_ampli() {
    translate(ampli_c - [ampli_pcb[0]/2 + 3.5, ampli_saillie/2 + 1]) square([ampli_pcb[0] + 7, ampli_saillie + 2]);
}
module empreinte_esp() { translate([usb_x - esp[0]/2, largeur - epaisseur_mur - esp[1]]) square(esp); }
module piliers2d() {
    for (c = coins) let (s = (c[1] < largeur/2) ? -1 : 1, y_c = c[1] + profondeur_pretrou * sin(angle) / 2)
        hull() for (dy = [0, s * 10]) translate([c[0], y_c + dy]) circle(d = d_pilier + 1);
}

module empreinte_chargeur() {
    translate([charge_x - ch_pcb[0]/2 - 1.6, ch_y_avant - 5]) square([ch_pcb[0] + 3.2, ch_pcb[1] + 5]);
}

module empreinte_survolteur() {
    translate([mt_x - mt_pcb[0]/2 - 1.6, mt_y - mt_pcb[1]/2 - 4]) square([mt_pcb[0] + 3.2, mt_pcb[1] + 8]);  // + 4 mm de fils à chaque bout
}

module empreinte_batterie() {
    L = bat[0] + 2*bat_jeu; W = bat[1] + 2*bat_jeu;
    translate(bat_centre) rotate(90) translate([-L/2, -W/2]) {
        translate([-2.2, -2.2]) square([L + 4.4, W + 4.4]);
        translate([L + 2, W/2 - 6]) square([4, 12]);   // fils
    }
}

module verif_bord() {
    // 1) composants qui mordent sur le mur / la lèvre
    intersection() { anneau_couv2d(0, epaisseur_mur + 0.9); empreintes_composants(); }
    // 2) têtes de vis trop près du bord arrondi
    intersection() {
        anneau_couv2d(0, arrondi_couvercle + 0.5);
        for (p = coins_couv) translate(p) circle(d = 6.5);
    }
    // 3) piliers qui touchent un composant ou l'ESP32-S3
    intersection() {
        for (p = coins_couv) translate(p) circle(d = d_pilier + 1);
        union() {
            empreintes_composants();
            translate([usb_x - esp[0]/2, (largeur - epaisseur_mur - esp[1]) * k_pente])
                square([esp[0], esp[1] * k_pente]);
        }
    }
    // 4) pions qui sortent de l'intérieur
    intersection() {
        anneau_couv2d(0, epaisseur_mur + 0.4);
        for (p = concat(pions_joy, pions_ecran)) translate(p) circle(d = d_pion_ecran);
    }
    // 5) composants qui se chevauchent
    for (i = [0 : NB_EMPREINTES - 2], j = [i + 1 : NB_EMPREINTES - 1])
        intersection() { empreinte(i); empreinte(j); }
    // 7) haut-parleur / ampli / piliers / ESP32 qui se touchent ou entrent dans le mur
    //    (contrôle en plan, ramené dans le repère du couvercle)
    scale([1, k_pente]) {
        intersection() { empreinte_hp(); union() { empreinte_ampli(); empreinte_esp(); piliers2d(); } }
        intersection() { empreinte_ampli(); union() { empreinte_esp(); piliers2d(); } }
        intersection() {
            union() { empreinte_hp(); empreinte_ampli(); }
            difference() { translate([-5, -5]) square([longueur + 10, largeur + 10]); haricot2d(epaisseur_mur); }
        }
    }
    // 9) collerettes des touches : contre une LED, entre elles, ou trop près du bord
    let (dc = touche_d + 2*touche_chanfrein + 2*touche_jeu + 1) {
        intersection() {
            for (y = y_touches) translate([x_touches, y]) circle(d = dc);
            union() {
                for (y = y_touches) translate([x_led_touche, y]) circle(d = d_led_touche);
                anneau_couv2d(0, arrondi_couvercle + 1);
            }
        }
        for (i = [0 : 1]) intersection() {
            translate([x_touches, y_touches[i]]) circle(d = dc - 1);
            translate([x_touches, y_touches[i + 1]]) circle(d = dc - 1);
        }
    }
    // 12) batterie contre le haut-parleur, l'ampli, l'ESP32, un pilier ou le mur
    scale([1, k_pente]) intersection() {
        empreinte_batterie();
        union() {
            empreinte_hp(); empreinte_ampli(); empreinte_esp(); piliers2d(); empreinte_chargeur();
            difference() { translate([-5, -5]) square([longueur + 10, largeur + 10]); haricot2d(epaisseur_mur + 0.5); }
        }
    }
    // 11) survolteur contre un pilier, le chargeur, le mur
    scale([1, k_pente]) intersection() {
        empreinte_survolteur();
        union() {
            piliers2d(); empreinte_esp(); empreinte_chargeur(); empreinte_batterie();
            difference() { translate([-5, -5]) square([longueur + 10, largeur + 10]); haricot2d(epaisseur_mur + 0.5); }
        }
    }
    // 10) chargeur contre un pilier, l'ESP32 ou l'ampli
    scale([1, k_pente]) intersection() {
        empreinte_chargeur();
        union() { empreinte_esp(); piliers2d(); empreinte_ampli(); }
    }
    // 11) berceau du micro contre la carte joystick, le bord ou une vis
    if (micro_forme != "aucun") intersection() {
        translate(c_micro) micro2d(micro_mur);
        union() {
            translate(c_joy) square(joy_pcb, center = true);
            translate(c_joy_axe) circle(d = d_joystick + 2 * chanfrein_joystick, $fn = 48);
            anneau_couv2d(0, epaisseur_mur + 0.4 - jeu);
            for (p = coins_couv) translate(p) circle(d = d_pilier + 1, $fn = 24);
        }
    }
    // 6) chanfrein du joystick trop près du bord du couvercle
    intersection() {
        anneau_couv2d(0, arrondi_couvercle + 1);
        translate(c_joy_axe) circle(d = d_joystick + 2 * chanfrein_joystick);
    }
}

// ====================================================================
// RENDU
// ====================================================================
echo(str("Survolteur : de Y = ", mt_y - mt_pcb[1]/2, " à ", mt_y + mt_pcb[1]/2, " (chargeur à partir de Y = ", ch_y_avant, ")"));
echo(str("Chargeur : carte de Y = ", ch_y_avant, " à ", ch_y_arriere, ", dessous à Z = ", ch_z_dessous));
echo(str("Boîtier : ", longueur, " x ", largeur, " mm, arrière ", hauteur_arriere, " mm"));
echo(str("Touches : ", fond_reel, " mm de plastique sous le doigt, pastille ", 
         epaisseur_couvercle - z_bas_touche, " mm de haut (dépasse de ", -z_bas_touche, " mm sous le couvercle)"));
echo(str("Micro : trou à ", micro_dist, " mm en avant de l'axe du joystick ; berceau ",
         micro_forme, " hors tout ", (micro_forme == "rond") ? micro_carte_d + 2 * micro_mur : micro_carte[0] + 2 * micro_mur,
         " mm, saillie ", micro_h, " mm sous le couvercle"));
echo(str("Haut-parleur : face à X = ", hp_face_x, " ; pions longs de ", hp_oreille_x - epaisseur_mur, " mm (avant) au plus"));
// 8) le haut-parleur doit passer sous les cartes TTP223 (≈ 3.5 mm sous le couvercle)
plafond_hp = hauteur_avant + (hp_y - hp_corps[0]/2) * tan(angle) - epaisseur_couvercle / cos(angle) - 3.5;
if (plafond_hp < hp_z + hp_corps[1]/2 + 0.5)
    echo(str("ATTENTION : haut-parleur trop haut de ", hp_z + hp_corps[1]/2 + 0.5 - plafond_hp, " mm"));
if (mode == "impression") {
    boitier_fond();
    translate([longueur + 25, largeur_couv, epaisseur_couvercle]) rotate([180, 0, 0]) couvercle_superieur();
} else if (mode == "boitier") {
    boitier_fond();
} else if (mode == "couvercle") {
    translate([0, largeur_couv, epaisseur_couvercle]) rotate([180, 0, 0]) couvercle_superieur();
} else if (mode == "touches") {
    // les 3 pastilles, cuvette vers le haut, prêtes pour le slicer
    for (i = [0 : 2])
        translate([i * (touche_d + 8), 0, -z_bas_touche]) translate([-x_touches, -y_touches[i], 0])
            pastille_touche([x_touches, y_touches[i]], ttp_sens[i]);
} else if (mode == "bride") {
    import(esp_bride_stl, convexity = 4);
} else if (mode == "assemblage") {
    boitier_fond();
    repere_couvercle() couvercle_superieur();
} else if (mode == "verif_bord") {
    verif_bord();
} else if (mode == "contour") {
    haricot2d();
}
