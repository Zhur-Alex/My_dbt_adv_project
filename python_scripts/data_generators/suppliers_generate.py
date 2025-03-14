from faker import Faker
import pandas as pd
import uuid
from datetime import datetime

#========== Г Е Н Е Р А Ц И Я _ П Р О И З В О Д И Т Е Л Е Й ==========

def generate_suppliers_data():
    fake_data = Faker("ru_RU")

    brands = {
        "Philip Morris International" : ["Malboro", "L&M"],
        "British American Tobacco" : ["Dunhill", "Kent"]
    }

    def supplier_generation():
        suppliers = []

        for company, brand_list in brands.items():
            for brand in brand_list:
                suppliers.append({
                    "supplier_pk" : 'supl' + str(uuid.uuid4())[:16].replace("-",""),
                    "company_name" : company,
                    "brand" : brand,
                    "country" : fake_data.country()
                })
        return suppliers

    suppliers_list = supplier_generation()

    df_suppliers = pd.DataFrame(suppliers_list)
    df_suppliers.to_csv(f"E:/DBT LEARNING/My_dbt_adv_project/seeds/raw_suppliers/sup_{datetime.today().strftime('%Y%m%d_%H%M%S')}.csv", index=False)

    suppliers_ids = [i["supplier_pk"] for i in suppliers_list]
