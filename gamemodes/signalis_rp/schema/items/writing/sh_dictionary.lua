
ITEM.name = "Dictionary"
ITEM.model = Model("models/eternalis/items/library/book.mdl")
ITEM.description = ""
ITEM.skin = 8

ITEM.weight = 0.4

ITEM.maxPages = 2
ITEM.startFromPage0 = true
ITEM.backgroundPhoto = "eternalis/documents/RES_Dossier_STCR.png" -- TODO: Change

ITEM.pages = {
    {
        {"「Dictionary」", Color(255, 255, 255), TEXT_ALIGN_CENTER}
    },

    [[Replika, /Re•pli•ká/, noun. Pl. Replikas (Kitezh: Replika).
Shortened from (archaic) Replikat (→Copy, →Replica).
Biomechanical person. Synthetic reproduction of a →Gestalt. Biological culture grafted
onto an artificial endoskeleton and enclosed in a protective exoskeleton.]],

    [[Gestalt, /Ge•shtalt/, noun. Pl.
Gestalts. Shortened from (archaic) Urgestalt (Original shape; compare →Archetype, →Prototype).
A person that is not a →Replika.]],
}
