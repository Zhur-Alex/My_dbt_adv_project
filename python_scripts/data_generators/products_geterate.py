from faker import Faker
import pandas as pd
import uuid
from datetime import datetime


#========== Г Е Н Е Р А Ц И Я _ П Р О Д У К Ц И И ==========

def generate_products_data():
    fake_data = Faker("ru_RU")

    products_dict = {
        'Malboro': ['Red', 'Gold', 'Ice Blast'],
        'L&M': ['Blue', 'Red Label', 'Forward'],
        'Winston': ['Classic', 'XStyle', 'Caster'],
        'Benson & Hedges': ['Premium', 'Select', 'Superkings']
    }

    def product_generation():
        products = []

        for brand, variant_list in products_dict.items():
            product_pk = 'prdc'+str(uuid.uuid4())[:16].replace("-","")
            category = "Сигареты" if brand in ["Malboro", "L&M"] else "Табак"
            for variant in variant_list:
                products.append({
                    "product_pk" : product_pk,
                    "brand" : brand,
                    "product_name" : f"{brand} {variant}",
                    "category" : category,
                    "price" : fake_data.random_int(150, 400) if category == "Сигареты" else fake_data.random_int(600, 1200)
                })
        return products

    products_list = product_generation()

    df_products = pd.DataFrame(products_list)
    df_products.to_csv(f"E:/DBT LEARNING/My_dbt_adv_project/seeds/raw_products/prdct_{datetime.today().strftime('%Y%m%d_%H%M%S')}", index=False)

    products_ids = [i["product_pk"] for i in products_list]
