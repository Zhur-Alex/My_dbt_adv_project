from faker import Faker
import pandas as pd
import uuid
import random
from datetime import datetime


#========== Г Е Н Е Р А Ц И Я _ М А Г А З И Н О В ==========

def generate_stores_data(num_stores):
    fake_data = Faker("ru_RU")

    stores = []
    cities = ["Москва", "Санкт-Петербург", "Новосибирск", "Саратов", "Краснодар"]
    
    for i in range(num_stores):
        stores.append({
            "store_pk": 'stor' + str(uuid.uuid4())[:12].replace("-",""),
            "name": f"Табачный магазин №{i+1}",
            "address": fake_data.street_address(),
            "city": random.choice(cities),
        })

    df_stores = pd.DataFrame(stores)
    df_stores.to_csv(f"E:/DBT LEARNING/My_dbt_adv_project/seeds/raw_stores/store_{datetime.today().strftime('%Y%m%d_%H%M%S')}", index=False)

    stores_ids = [i["store_pk"] for i in stores]
