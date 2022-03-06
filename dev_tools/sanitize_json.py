import json

output = {}

input_file = open('dev_tools/input/Fct.json')
data = json.load(input_file)

for i in data:
    output[i["C_DESCR"].replace('*','').strip()] = i
    del output[i["C_DESCR"].replace('*','').strip()]["C_DESCR"]

input_file = open('dev_tools/input/RetentionFactors.json')
data = json.load(input_file)

for i in data:
    output[i["R_Descr"].replace('*','').strip()] = {
    "C_CODE": i["R_Code"],
    "C_STATE": 1,
    "C_DRYMATTER_G": i["R_DryM"],
    "C_WATER_G": i["R_Water"],
    "C_ENERG_KCAL": i["R_Energy"],
    "C_PROTEIN_G": i["R_Protein"],
    "C_LIPID_TOT_G": i["R_Lipid"],
    "C_CARBOHYDRT_G": i["R_Cho"],
    "C_FIBER_TD_G": i["R_Fiber"],
    "C_CALCIUM_MG": i["R_Ca"],
    "C_IRON_MG": i["R_Fe"],
    "C_ZINC_MG": i["R_Zn"],
    "C_VIT_C_MG": i["R_VitC"],
    "C_THIAMIN_MG": i["R_Thiamin"],
    "C_RIBOFLAVIN_MG": i["R_Riboflavin"],
    "C_NIACIN_MG": i["R_Niacin"],
    "C_VIT_B6_MG": i["R_VitB_6"],
    "C_FOLATE_TOT_MCG": i["R_Folate_food"],
    "C_FOLIC_ACID_MCG": i["R_FolicAcid"],
    "C_FOOD_FOLATE_MCG": i["R_Folate_total"],
    "C_FOLATE_MCG_DFE": i["R_Folate_DFE"],
    "C_VIT_B12_MCG": i["R_VitB_12"],
    "C_VIT_A_IU": i["R_VitA_IU"],
    "C_VIT_A_MCG_RAE": i["R_VitA_RE"],
    "C_RETINOL_MCG": i["R_Retinol"],
    "C_ALPHA_CAROT_MCG": i["R_AlphaCarotene"],
    "C_BETA_CAROT_MCG": i["R_BetaCarotene"],
    "C_BETA_CRYPT_MCG": i["R_BetaCryptoxanthin"]
    }


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
with open("dev_tools/output/ingredients.json", "w") as outfile:
    json.dump(output, outfile, indent=4, sort_keys=False)