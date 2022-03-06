import json

output = {}

input_file = open('dev_tools/input/Fct.json')
data = json.load(input_file)

for i in data:
    output[i["C_DESCR"].replace('*','').strip()] = i
    del output[i["C_DESCR"].replace('*','').strip()]["C_DESCR"]

output["Other (please specify)"] = {
        "C_CODE": -1,
        "C_STATE": 0,
        "C_DRYMATTER_G": 0,
        "C_WATER_G": 0,
        "C_ENERG_KCAL": 0,
        "C_PROTEIN_G": 0,
        "C_LIPID_TOT_G": 0,
        "C_CARBOHYDRT_G": 0,
        "C_FIBER_TD_G": 0,
        "C_CALCIUM_MG": 0,
        "C_IRON_MG": 0,
        "C_ZINC_MG": 0,
        "C_VIT_C_MG": 0,
        "C_THIAMIN_MG": 0,
        "C_RIBOFLAVIN_MG": 0,
        "C_NIACIN_MG": 0,
        "C_VIT_B6_MG": 0,
        "C_FOLATE_TOT_MCG": 0,
        "C_FOLIC_ACID_MCG": 0,
        "C_FOOD_FOLATE_MCG": 0,
        "C_FOLATE_MCG_DFE": 0,
        "C_VIT_B12_MCG": 0,
        "C_VIT_A_IU": 0,
        "C_VIT_A_MCG_RAE": 0,
        "C_RETINOL_MCG": 0,
        "C_ALPHA_CAROT_MCG": 0,
        "C_BETA_CAROT_MCG": 0,
        "C_BETA_CRYPT_MCG": 0
    }

json_output = json.dumps(output)
with open("assets/ingredients/ingredients.json", "w") as outfile:
    json.dump(output, outfile, indent=4, sort_keys=False)