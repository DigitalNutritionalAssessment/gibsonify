const ifct2017 = require('ifct2017');
const pictures = require('@ifct2017/pictures')
const languageMap = require('@ifct2017/languages/corpus');

const fs = require('fs');

const FCT_OUTPUT_PATH = '../../../assets/fct/ifct2017/'
const FCT_ITEM_PHOTO_PATH = 'assets/fct/ifct2017/photos/';

// Maps FCT2017 group IDs to DDS group IDs as defined in 
// FAO: Guidelines for measuring household and individual#
// dietary diversity
function ddsGroupId(composition, groupId) {
    if (groupId == 'A') {
        // Cereals and Millets -> CEREALS
        return 1;
    }

    if (groupId == 'B') {
        // Grain Legumes -> LEGUMES, NUTS, SEEDS
        return 12;
    }

    if (groupId == 'C') {
        // Green Leafy Vegetables -> DARK GREEN LEAFY VEGETABLES
        return 4;
    }

    if (groupId == 'D') {
        // Other Vegetables -> OTHER VEGETABLES
        return 5;
    }

    if (groupId == 'E') {
        // Fruits
        const vitARichFruits = ['mango', 'cantaloupe', 'apricot', 'papaya', 'peach'];
        if (vitARichFruits.some((name) => composition.name.toLowerCase().includes(name))) {
            // -> VITAMIN A-RICH FRUITS
            return 6;
        }

        // -> OTHER FRUITS
        return 7;
    }

    if (groupId == 'F') {
        // Roots and Tubers
        if (composition.name.toLowerCase().includes('white')) {
            // -> WHITE ROOTS AND TUBERS
            return 2;
        }

        const vitARichRots = ['carrot', 'sweet potato', 'pumpkin', 'squash'];
        if (vitARichRots.some((name) => composition.name.toLowerCase().includes(name))) {
            // -> VITAMIN A-RICH VEGETABLES AND TUBERS
            return 3;
        }

        // -> OTHER VEGETABLES
        return 5;
    }

    if (groupId == 'G') {
        // Condiments and Spices -> SPICES, CONDIMENTS, BEVERAGES
        return 16;
    }

    if (groupId == 'H') {
        // Nuts and Oil Seeds -> LEGUMES, NUTS, SEEDS
        return 12;
    }

    if (groupId == 'I') {
        // Sugars -> SWEETS
        return 15;
    }

    if (groupId == 'J') {
        // Mushrooms -> OTHER VEGETABLES
        return 5;
    }

    if (groupId == 'K') {
        // Miscellaneous Foods -> SPICES, CONDIMENTS, BEVERAGES
        // (K contains only toddy and coconut water)
        return 16;
    }

    if (groupId == 'L') {
        // Milk and Milk Products -> MILK AND MILK PRODUCTS
        return 13;
    }

    if (groupId == 'M') {
        // Egg and Egg Products -> EGGS
        return 10;
    }

    if (groupId == 'N' || groupId == 'O') {
        // Poultry, Animal Meat
        const organMeats = ['liver', 'kidney', 'heart', 'brain', 'intestine', 'stomach', 'lung', 'spleen'];
        if (organMeats.some((name) => composition.name.toLowerCase().includes(name))) {
            // -> ORGAN MEATS
            return 8;
        }

        // -> FLESH MEATS
        return 9;
    }

    if (groupId == 'P' || groupId == 'Q' || groupId == 'R' || groupId == 'S') {
        // Marine Fish, Marine Shellfish, Marine Mollusks, Fresh Water Fish and Shellfish 
        // -> FISH AND SEAFOOD
        return 11;
    }

    if (groupId == 'T') {
        // Edible Oils and Fats -> OILS AND FATS
        return 14;
    }
}

async function main() {
    ifct2017.groups.load()
    await ifct2017.compositions.load()
    const allGroups = ifct2017.groups('');
    const allCompositions = ifct2017.compositions('');

    const groupMap = {};
    allGroups.forEach(group => {
        groupMap[group.code] = {
            id: group.code,
            name: group.group,
            foodItemIds: [],
        };
    });

    const compositionMap = {};
    allCompositions.forEach(composition => {
        const groupId = composition.code[0];
        const absPhotoPath = pictures(composition.code)?.replace('pictures\\', 'pictures\\assets\\');
        var photoUrl = null;
        if (absPhotoPath) {
            photoUrl = `${FCT_ITEM_PHOTO_PATH}${composition.code}.jpg`;
            fs.copyFile(absPhotoPath, `${FCT_OUTPUT_PATH}photos/${composition.code}.jpg`, (err) => {
                if (err) { throw new Error(`File copy for ${composition.code} failed: ${err}`) }
            });
        } else {
            console.warn(`No photo for ${composition.code} (${composition.name}))`)
        }

        let alternateNames = [];
        if (composition.lang.length > 0) {
            for (const alt of composition.lang.split(';')) {
                if (alt.length > 0) {
                    const entry = alt.replace(' ', '').split('.');
                    let langAbbr, altNames;
                    try {
                        langAbbr = entry[0].trim().toLowerCase();
                        altNames = entry[1].split(',').map(n => n.trim());
                    } catch (e) {
                        console.warn(`Failed to parse alternate name entry for ${composition.code}: ${alt}`);
                        continue;
                    }
                    const lang = languageMap.get(langAbbr);
                    if (lang) {
                        for (const altName of altNames) {
                            alternateNames.push(`${altName} (${lang.lang})`);
                        }
                    } else {
                        console.warn(`Language ${langAbbr} not found for ${composition.code} (${entry})`);
                    }
                }
            }
        }

        compositionMap[composition.code] = {
            id: composition.code,
            name: composition.name,
            scientificName: composition.scie,
            alternateNames: alternateNames,
            foodGroupId: groupId,
            ddsGroupId: ddsGroupId(composition, groupId),
            photoUrl: photoUrl,
            nutrition: {
                energy_kj: composition.enerc,
                carbohydrate_g: composition.choavldf,
                protein_g: composition.protcnt,
                fat_g: composition.fatce,
                fibre_g: composition.fibtg,
                moisture_g: composition.water,
                ash_g: composition.ash,
                vit_a_g: composition.vita,
                vit_b1_g: composition.thia,
                vit_b2_g: composition.ribf,
                vit_b3_g: composition.nia,
                vit_b5_g: composition.pantac,
                vit_b6_g: composition.pyrdx,
                vit_b7_g: composition.biot,
                vit_b9_g: composition.folsum,
                vit_c_g: composition.vitc,
                vit_d2_g: composition.ergcal,
                vit_e_g: composition.vite,
                vit_k1_g: composition.vitk1,
                vit_k2_g: composition.vitk2,
            }
        };

        groupMap[groupId].foodItemIds.push(composition.code);
    });

    let fctData = JSON.stringify({
        groups: groupMap,
        compositions: compositionMap,
    }, null, 2)

    fs.writeFile(`${FCT_OUTPUT_PATH}fct.json`, fctData, (err) => {
        if (err) { throw new Error(`File write failed: ${err}`) }
    });
}

main()